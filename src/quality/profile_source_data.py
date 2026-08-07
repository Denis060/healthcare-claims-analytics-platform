import csv
import logging
import os
from collections import Counter, defaultdict
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import pandas as pd

RAW_DATA_DIR = Path(__file__).resolve().parents[2] / "data" / "raw"
OUTPUT_DIR = Path(__file__).resolve().parents[2] / "docs" / "source_profile"
PRIORITY_FILES = [
    "patients.csv",
    "encounters.csv",
    "conditions.csv",
    "procedures.csv",
    "claims.csv",
    "claims_transactions.csv",
    "providers.csv",
    "payers.csv",
]

logger = logging.getLogger("source_data_profiler")


@dataclass
class ColumnProfile:
    name: str
    dtype: str
    non_null_count: int
    null_count: int
    null_pct: float
    unique_count: int
    unique_pct: float
    duplicate_count: int
    sample_values: List[Any]
    min_value: Optional[Any]
    max_value: Optional[Any]
    mean_value: Optional[float]
    inferred_type: str


@dataclass
class TableProfile:
    filename: str
    row_count: int
    column_count: int
    column_profiles: List[ColumnProfile]
    duplicate_rows: int
    candidate_primary_keys: List[str]
    likely_foreign_keys: List[str]
    source_path: Path


def _is_date_series(series: pd.Series) -> bool:
    if pd.api.types.is_datetime64_any_dtype(series.dtype):
        return True
    if pd.api.types.is_integer_dtype(series.dtype) or pd.api.types.is_float_dtype(series.dtype):
        return False
    parsed = pd.to_datetime(series.dropna(), errors="coerce")
    return parsed.notna().all()


def _infer_column_type(series: pd.Series) -> str:
    if pd.api.types.is_integer_dtype(series.dtype):
        return "integer"
    if pd.api.types.is_float_dtype(series.dtype):
        return "float"
    if pd.api.types.is_bool_dtype(series.dtype):
        return "boolean"
    if _is_date_series(series):
        return "datetime"
    return "string"


def _sample_values(series: pd.Series, max_samples: int = 10) -> List[Any]:
    values = series.dropna().astype(str)
    return values.value_counts().head(max_samples).index.tolist()


def _profile_column(series: pd.Series, name: str) -> ColumnProfile:
    non_null = int(series.notna().sum())
    null_count = int(series.isna().sum())
    total = len(series)
    unique_count = int(series.nunique(dropna=True))
    null_pct = null_count / total if total else 0.0
    unique_pct = unique_count / total if total else 0.0
    inferred_type = _infer_column_type(series)

    min_value = None
    max_value = None
    mean_value = None

    if inferred_type in {"integer", "float"}:
        numeric = pd.to_numeric(series, errors="coerce")
        min_value = numeric.min() if not numeric.dropna().empty else None
        max_value = numeric.max() if not numeric.dropna().empty else None
        mean_value = float(numeric.mean()) if not numeric.dropna().empty else None
    elif inferred_type == "datetime":
        parsed = pd.to_datetime(series, errors="coerce")
        parsed = parsed.dropna()
        if not parsed.empty:
            min_value = parsed.min()
            max_value = parsed.max()

    duplicate_count = int(series.duplicated().sum())
    sample_values = _sample_values(series)

    return ColumnProfile(
        name=name,
        dtype=str(series.dtype),
        non_null_count=non_null,
        null_count=null_count,
        null_pct=null_pct,
        unique_count=unique_count,
        unique_pct=unique_pct,
        duplicate_count=duplicate_count,
        sample_values=sample_values,
        min_value=min_value,
        max_value=max_value,
        mean_value=mean_value,
        inferred_type=inferred_type,
    )


def _find_candidate_keys(df: pd.DataFrame) -> List[str]:
    candidates = []
    for column in df.columns:
        unique_count = int(df[column].nunique(dropna=True))
        if unique_count == len(df) and not df[column].isna().any():
            candidates.append(column)
    return candidates


def _collect_id_columns(df: pd.DataFrame) -> List[str]:
    return [c for c in df.columns if any(term in c.lower() for term in ["id", "key", "code", "number"]) and df[c].dtype != object or "id" in c.lower()]


def _profile_table(path: Path) -> TableProfile:
    logger.info("Profiling %s", path)
    df = pd.read_csv(path)
    row_count = len(df)
    column_count = len(df.columns)
    duplicate_rows = int(df.duplicated().sum())
    column_profiles = [_profile_column(df[col], col) for col in df.columns]
    candidate_primary_keys = _find_candidate_keys(df)
    likely_foreign_keys = _collect_id_columns(df)
    return TableProfile(
        filename=path.name,
        row_count=row_count,
        column_count=column_count,
        column_profiles=column_profiles,
        duplicate_rows=duplicate_rows,
        candidate_primary_keys=candidate_primary_keys,
        likely_foreign_keys=likely_foreign_keys,
        source_path=path,
    )


def _build_foreign_key_hints(profiles: List[TableProfile]) -> Dict[str, List[str]]:
    id_columns = defaultdict(list)
    for profile in profiles:
        for col in profile.likely_foreign_keys:
            id_columns[col.lower()].append(profile.filename)
    hints = {}
    for profile in profiles:
        matches = set()
        for col in profile.likely_foreign_keys:
            key = col.lower()
            if len(id_columns[key]) > 1:
                matches.add(col)
        hints[profile.filename] = sorted(matches)
    return hints


def _render_markdown_report(profiles: List[TableProfile], foreign_key_hints: Dict[str, List[str]]) -> str:
    rows = [
        "# Source Data Profile Report",
        "",
        f"Generated: {datetime.utcnow().isoformat()}Z",
        "",
        "## Priority files",
        "",
    ]
    for filename in PRIORITY_FILES:
        marker = "✅" if any(p.filename == filename for p in profiles) else "⚠️"
        rows.append(f"- {marker} `{filename}`")
    rows.extend(["", "## Table summaries", ""])

    for profile in sorted(profiles, key=lambda p: (p.filename not in PRIORITY_FILES, p.filename)):
        rows.append(f"### {profile.filename}")
        rows.append("")
        rows.append(f"- Rows: {profile.row_count}")
        rows.append(f"- Columns: {profile.column_count}")
        rows.append(f"- Duplicate rows: {profile.duplicate_rows}")
        rows.append(f"- Candidate primary keys: {', '.join(profile.candidate_primary_keys) or 'None'}")
        rows.append(f"- Likely ID-like columns: {', '.join(profile.likely_foreign_keys) or 'None'}")
        rows.append(f"- Likely foreign-key hints: {', '.join(foreign_key_hints.get(profile.filename, [])) or 'None'}")
        rows.append("")
        rows.append("| Column | Pandas dtype | Inferred type | Null % | Unique % | Sample values | Min | Max | Mean |")
        rows.append("|---|---|---|---|---|---|---|---|---|")
        for col_profile in profile.column_profiles:
            sample = "; ".join(map(str, col_profile.sample_values[:5]))
            rows.append(
                f"| `{col_profile.name}` | {col_profile.dtype} | {col_profile.inferred_type} | {col_profile.null_pct:.2%} | {col_profile.unique_pct:.2%} | {sample} | {col_profile.min_value} | {col_profile.max_value} | {col_profile.mean_value} |"
            )
        rows.append("")
    return "\n".join(rows)


def _build_summary_dataframe(profiles: List[TableProfile]) -> pd.DataFrame:
    summary_rows = []
    for profile in profiles:
        for col_profile in profile.column_profiles:
            summary_rows.append(
                {
                    "filename": profile.filename,
                    "row_count": profile.row_count,
                    "column_count": profile.column_count,
                    "duplicate_rows": profile.duplicate_rows,
                    "candidate_primary_keys": ", ".join(profile.candidate_primary_keys) or None,
                    "likely_foreign_keys": ", ".join(profile.likely_foreign_keys) or None,
                    "column_name": col_profile.name,
                    "dtype": col_profile.dtype,
                    "inferred_type": col_profile.inferred_type,
                    "null_count": col_profile.null_count,
                    "null_pct": col_profile.null_pct,
                    "unique_count": col_profile.unique_count,
                    "unique_pct": col_profile.unique_pct,
                    "sample_values": "; ".join(map(str, col_profile.sample_values[:5])),
                    "min_value": col_profile.min_value,
                    "max_value": col_profile.max_value,
                    "mean_value": col_profile.mean_value,
                }
            )
    return pd.DataFrame(summary_rows)


def main() -> None:
    logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)s %(message)s")
    logger.info("Starting source data profiling")

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    csv_files = sorted(RAW_DATA_DIR.glob("*.csv"))
    logger.info("Found %s CSV files in %s", len(csv_files), RAW_DATA_DIR)

    profiles = []
    for path in csv_files:
        try:
            profiles.append(_profile_table(path))
        except Exception as exc:
            logger.exception("Failed to profile %s: %s", path, exc)

    foreign_key_hints = _build_foreign_key_hints(profiles)
    summary_df = _build_summary_dataframe(profiles)
    summary_path = OUTPUT_DIR / "source_profile_summary.csv"
    report_path = OUTPUT_DIR / "source_profile_report.md"

    summary_df.to_csv(summary_path, index=False)
    logger.info("Wrote summary CSV to %s", summary_path)

    report = _render_markdown_report(profiles, foreign_key_hints)
    report_path.write_text(report, encoding="utf-8")
    logger.info("Wrote markdown report to %s", report_path)

    logger.info("Source data profiling complete")


if __name__ == "__main__":
    main()
