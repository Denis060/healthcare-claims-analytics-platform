#!/usr/bin/env python3
"""Load Synthea source CSV files into the PostgreSQL raw schema.

This script follows the raw schema defined in sql/ddl/000_create_raw_schema.sql.
It validates source files, checks missing required columns, preserves IDs exactly,
and loads each file into its matching raw table while allowing the DB to populate
_loaded_at by default.
"""

from __future__ import annotations

import argparse
import logging
import sys
import time
from pathlib import Path
from typing import Iterable

import pandas as pd
from sqlalchemy import text

PROJECT_ROOT = Path(__file__).resolve().parents[2]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from src.utils.db import create_db_engine  # noqa: E402

RAW_DATA_DIR = PROJECT_ROOT / "data" / "raw"

FILE_TO_TABLE = {
    "patients.csv": {
        "table": "raw.patients",
        "required_columns": [
            "Id",
            "BIRTHDATE",
            "DEATHDATE",
            "SSN",
            "DRIVERS",
            "PASSPORT",
            "PREFIX",
            "FIRST",
            "MIDDLE",
            "LAST",
            "SUFFIX",
            "MAIDEN",
            "MARITAL",
            "RACE",
            "ETHNICITY",
            "GENDER",
            "BIRTHPLACE",
            "ADDRESS",
            "CITY",
            "STATE",
            "COUNTY",
            "FIPS",
            "ZIP",
            "LAT",
            "LON",
            "HEALTHCARE_EXPENSES",
            "HEALTHCARE_COVERAGE",
            "INCOME",
        ],
    },
    "encounters.csv": {
        "table": "raw.encounters",
        "required_columns": [
            "Id",
            "START",
            "STOP",
            "PATIENT",
            "ORGANIZATION",
            "PROVIDER",
            "PAYER",
            "ENCOUNTERCLASS",
            "CODE",
            "DESCRIPTION",
            "BASE_ENCOUNTER_COST",
            "TOTAL_CLAIM_COST",
            "PAYER_COVERAGE",
            "REASONCODE",
            "REASONDESCRIPTION",
        ],
    },
    "conditions.csv": {
        "table": "raw.conditions",
        "required_columns": [
            "START",
            "STOP",
            "PATIENT",
            "ENCOUNTER",
            "SYSTEM",
            "CODE",
            "DESCRIPTION",
        ],
    },
    "procedures.csv": {
        "table": "raw.procedures",
        "required_columns": [
            "START",
            "STOP",
            "PATIENT",
            "ENCOUNTER",
            "SYSTEM",
            "CODE",
            "DESCRIPTION",
            "BASE_COST",
            "REASONCODE",
            "REASONDESCRIPTION",
        ],
    },
    "claims.csv": {
        "table": "raw.claims",
        "required_columns": [
            "Id",
            "PATIENTID",
            "PROVIDERID",
            "PRIMARYPATIENTINSURANCEID",
            "SECONDARYPATIENTINSURANCEID",
            "DEPARTMENTID",
            "PATIENTDEPARTMENTID",
            "DIAGNOSIS1",
            "DIAGNOSIS2",
            "DIAGNOSIS3",
            "DIAGNOSIS4",
            "DIAGNOSIS5",
            "DIAGNOSIS6",
            "DIAGNOSIS7",
            "DIAGNOSIS8",
            "REFERRINGPROVIDERID",
            "APPOINTMENTID",
            "CURRENTILLNESSDATE",
            "SERVICEDATE",
            "SUPERVISINGPROVIDERID",
            "STATUS1",
            "STATUS2",
            "STATUSP",
            "OUTSTANDING1",
            "OUTSTANDING2",
            "OUTSTANDINGP",
            "LASTBILLEDDATE1",
            "LASTBILLEDDATE2",
            "LASTBILLEDDATEP",
            "HEALTHCARECLAIMTYPEID1",
            "HEALTHCARECLAIMTYPEID2",
        ],
    },
    "claims_transactions.csv": {
        "table": "raw.claims_transactions",
        "required_columns": [
            "ID",
            "CLAIMID",
            "CHARGEID",
            "PATIENTID",
            "TYPE",
            "AMOUNT",
            "METHOD",
            "FROMDATE",
            "TODATE",
            "PLACEOFSERVICE",
            "PROCEDURECODE",
            "MODIFIER1",
            "MODIFIER2",
            "DIAGNOSISREF1",
            "DIAGNOSISREF2",
            "DIAGNOSISREF3",
            "DIAGNOSISREF4",
            "UNITS",
            "DEPARTMENTID",
            "NOTES",
            "UNITAMOUNT",
            "TRANSFEROUTID",
            "TRANSFERTYPE",
            "PAYMENTS",
            "ADJUSTMENTS",
            "TRANSFERS",
            "OUTSTANDING",
            "APPOINTMENTID",
            "LINENOTE",
            "PATIENTINSURANCEID",
            "FEESCHEDULEID",
            "PROVIDERID",
            "SUPERVISINGPROVIDERID",
        ],
    },
    "providers.csv": {
        "table": "raw.providers",
        "required_columns": [
            "Id",
            "ORGANIZATION",
            "NAME",
            "GENDER",
            "SPECIALTY",
            "ADDRESS",
            "CITY",
            "STATE",
            "ZIP",
            "LAT",
            "LON",
            "ENCOUNTERS",
            "PROCEDURES",
        ],
    },
    "payers.csv": {
        "table": "raw.payers",
        "required_columns": [
            "Id",
            "NAME",
            "OWNERSHIP",
            "ADDRESS",
            "CITY",
            "STATE_HEADQUARTERED",
            "ZIP",
            "PHONE",
            "AMOUNT_COVERED",
            "AMOUNT_UNCOVERED",
            "REVENUE",
            "COVERED_ENCOUNTERS",
            "UNCOVERED_ENCOUNTERS",
            "COVERED_MEDICATIONS",
            "UNCOVERED_MEDICATIONS",
            "COVERED_PROCEDURES",
            "UNCOVERED_PROCEDURES",
            "COVERED_IMMUNIZATIONS",
            "UNCOVERED_IMMUNIZATIONS",
            "UNIQUE_CUSTOMERS",
            "QOLS_AVG",
            "MEMBER_MONTHS",
        ],
    },
    "organizations.csv": {
        "table": "raw.organizations",
        "required_columns": [
            "Id",
            "NAME",
            "ADDRESS",
            "CITY",
            "STATE",
            "ZIP",
            "LAT",
            "LON",
            "PHONE",
            "REVENUE",
            "UTILIZATION",
        ],
    },
}

TABLE_NAMES = sorted({meta["table"].split(".")[-1] for meta in FILE_TO_TABLE.values()})
COLUMN_ALIASES = {
    "providers.csv": {
        "SPECIALITY": "SPECIALTY",
    }
}


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=(
            "Load Synthea CSV files into the PostgreSQL raw schema using the raw DDL as the "
            "source of truth."
        ),
        epilog=(
            "Examples:\n"
            "  python src/etl/load_raw_data.py --table patients --truncate-first\n"
            "  python src/etl/load_raw_data.py --table claims_transactions --truncate-first\n"
            "  python src/etl/load_raw_data.py --all\n"
            "  python src/etl/load_raw_data.py"
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "--table",
        choices=sorted(TABLE_NAMES + [f"raw.{name}" for name in TABLE_NAMES] + [f"{name}.csv" for name in TABLE_NAMES]),
        help="Load a single raw table (for example: patients, raw.patients, or patients.csv).",
    )
    parser.add_argument(
        "--all",
        action="store_true",
        help="Load every file configured in the raw schema (default behavior).",
    )
    parser.add_argument(
        "--truncate-first",
        action="store_true",
        help="Truncate the destination raw table before appending rows.",
    )
    parser.add_argument(
        "--chunk-size",
        type=int,
        default=5000,
        help="Chunk size for pandas to_sql inserts (default: 5000).",
    )
    return parser


def normalize_table_name(value: str | None) -> str | None:
    if value is None:
        return None
    normalized = value.strip().lower()
    if normalized.endswith(".csv"):
        normalized = normalized[:-4]
    normalized = normalized.replace("raw.", "")
    return normalized


def resolve_target_tables(args: argparse.Namespace) -> list[str]:
    if args.table and args.all:
        raise ValueError("Choose either --table or --all, not both.")

    if args.table:
        table_key = normalize_table_name(args.table)
        matches = []
        for file_name, meta in FILE_TO_TABLE.items():
            candidate = meta["table"].split(".")[-1].lower()
            if candidate == table_key or file_name.lower().replace(".csv", "") == table_key:
                matches.append(file_name)
        if not matches:
            raise ValueError(f"Unknown table: {args.table}. Supported values: {sorted(TABLE_NAMES)}")
        return matches

    return list(FILE_TO_TABLE.keys())


def normalize_input_columns(file_name: str, df: pd.DataFrame) -> pd.DataFrame:
    aliases = COLUMN_ALIASES.get(file_name, {})
    if aliases:
        df = df.rename(columns=aliases)
    return df


def validate_required_columns(file_name: str, df: pd.DataFrame) -> None:
    required_columns = FILE_TO_TABLE[file_name]["required_columns"]
    missing = [col for col in required_columns if col not in df.columns]
    if missing:
        raise ValueError(
            f"{file_name} is missing required columns for {FILE_TO_TABLE[file_name]['table']}: "
            f"{missing}"
        )


def truncate_table(engine, table_name: str) -> None:
    with engine.begin() as conn:
        conn.execute(text(f'TRUNCATE TABLE {table_name} RESTART IDENTITY;'))


def load_single_file(engine, file_name: str, chunk_size: int, truncate_first: bool = False) -> dict:
    file_path = RAW_DATA_DIR / file_name
    if not file_path.exists():
        raise FileNotFoundError(f"Required source file not found: {file_path}")

    table_name = FILE_TO_TABLE[file_name]["table"]
    start_time = time.perf_counter()

    try:
        df = pd.read_csv(file_path, dtype=str, keep_default_na=False)
    except Exception as exc:  # pragma: no cover - defensive error reporting
        elapsed = round(time.perf_counter() - start_time, 2)
        return {
            "file": file_name,
            "target_table": table_name,
            "rows_read": 0,
            "rows_loaded": 0,
            "elapsed_seconds": elapsed,
            "status": "failed",
            "failure": f"CSV read error: {exc}",
        }

    df = normalize_input_columns(file_name, df)
    validate_required_columns(file_name, df)
    rows_read = len(df)

    # Treat blank cells in source CSVs as SQL NULLs so date/numeric columns can load
    # without PostgreSQL raising "invalid input syntax for type" errors.
    df = df.replace(r"^\s*$", pd.NA, regex=True)
    df = df.where(pd.notna(df), None)

    columns_to_keep = FILE_TO_TABLE[file_name]["required_columns"]
    df = df.loc[:, columns_to_keep].copy()
    df["_source_file"] = file_name

    if truncate_first:
        truncate_table(engine, table_name)

    rows_loaded = 0
    try:
        with engine.begin() as conn:
            rows_loaded = df.to_sql(
                name=table_name.split(".")[-1],
                con=conn,
                schema=table_name.split(".")[0],
                if_exists="append",
                index=False,
                chunksize=chunk_size,
                method="multi",
            )
        rows_loaded = rows_read
    except Exception as exc:
        elapsed = round(time.perf_counter() - start_time, 2)
        return {
            "file": file_name,
            "target_table": table_name,
            "rows_read": rows_read,
            "rows_loaded": 0,
            "elapsed_seconds": elapsed,
            "status": "failed",
            "failure": f"Insert failed: {exc}",
        }

    elapsed = round(time.perf_counter() - start_time, 2)
    return {
        "file": file_name,
        "target_table": table_name,
        "rows_read": rows_read,
        "rows_loaded": rows_loaded,
        "elapsed_seconds": elapsed,
        "status": "success",
        "failure": None,
    }


def main() -> int:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
    parser = build_parser()
    args = parser.parse_args()

    try:
        target_files = resolve_target_tables(args)
    except ValueError as exc:
        logging.error(str(exc))
        parser.print_usage(sys.stderr)
        return 2

    engine = create_db_engine()
    all_results = []

    for file_name in target_files:
        logging.info("Starting load: file=%s target=%s", file_name, FILE_TO_TABLE[file_name]["table"])
        try:
            result = load_single_file(
                engine=engine,
                file_name=file_name,
                chunk_size=args.chunk_size,
                truncate_first=args.truncate_first,
            )
            all_results.append(result)
            if result["status"] == "success":
                logging.info(
                    "Loaded file=%s target=%s rows_read=%s rows_loaded=%s elapsed_seconds=%s",
                    result["file"],
                    result["target_table"],
                    result["rows_read"],
                    result["rows_loaded"],
                    result["elapsed_seconds"],
                )
            else:
                logging.error(
                    "Failed file=%s target=%s rows_read=%s rows_loaded=%s elapsed_seconds=%s failure=%s",
                    result["file"],
                    result["target_table"],
                    result["rows_read"],
                    result["rows_loaded"],
                    result["elapsed_seconds"],
                    result["failure"],
                )
        except Exception as exc:
            logging.exception("Load failure for %s: %s", file_name, exc)
            all_results.append(
                {
                    "file": file_name,
                    "target_table": FILE_TO_TABLE[file_name]["table"],
                    "rows_read": 0,
                    "rows_loaded": 0,
                    "elapsed_seconds": 0,
                    "status": "failed",
                    "failure": str(exc),
                }
            )

    failed = [result for result in all_results if result["status"] == "failed"]
    if failed:
        for item in failed:
            logging.error(
                "FAILED file=%s target=%s failure=%s",
                item["file"],
                item["target_table"],
                item["failure"],
            )
        return 1

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
