# Data architecture

The platform follows a production-style data flow:

CSV -> raw -> validation -> core -> analytics -> Power BI

## 1. CSV layer

The source-of-truth files live in the raw data folder and represent the exported Synthea datasets. These files are treated as immutable upstream inputs.

Purpose:
- preserve the original data contract from the vendor/export source
- keep a traceable record of the exact source files used for the project
- support data profiling and source-level validation before any transformation logic is applied

## 2. Raw layer

The raw schema is intentionally permissive. Its purpose is ingestion, lineage, and preservation of source structure.

Characteristics:
- tables live in the raw schema
- column names mirror the CSV headers as closely as possible
- source IDs are preserved exactly as they appear in the files
- no foreign keys or strict referential constraints are enforced
- data types are safe for ingestion but not yet curated for analytics
- every raw table includes _loaded_at and _source_file for auditability

Why no referential integrity in raw?
- source files may contain partial or temporary data during ingestion
- many CSVs can be loaded independently before full joins are validated
- raw ingestion should fail only on parsing or file-level issues, not on cross-table key mismatches
- this keeps the raw layer resilient and allows validation to happen explicitly before promotion into the curated core layer

## 3. Validation layer

Before data is promoted into curated core tables, validation checks confirm that all candidate PK/FK relationships are consistent.

This includes:
- row counts by table
- null-key analysis
- matched vs unmatched child keys
- match-rate reporting for each proposed relationship
- checks against raw tables before the curated layer is populated

This step is where evidence-based decisions are enforced. If a relationship does not meet the expected integrity threshold, it is not promoted into the curated schema.

## 4. Core layer

The core schema contains curated, production-ready tables for downstream analytical usage.

Characteristics:
- tables live in the core schema
- primary keys are validated and normalized
- foreign keys are only defined where evidence supports them
- column names are standardized to lower_snake_case
- date/time values are typed appropriately
- monetary values use NUMERIC instead of floating-point approximations
- indexes are added for expected join patterns and query performance

This layer is the trusted analytical foundation for downstream data products.

## 5. Analytics layer

Once data is loaded into core, analytical views, derived tables, and summary models can be built on top of the curated schema.

Purpose:
- unify facts and dimensions
- support healthcare claims and utilization analyses
- enable cohort, provider, payer, and network-level reporting
- create a stable layer for SQL, Python, and BI consumption

## 6. Power BI / reporting layer

Power BI reads the curated analytical output rather than the raw source files.

Benefits:
- stable data contracts
- cleaner semantics and normalized naming
- better trust in KPI calculations and joins
- easier governance and lineage tracking

## Why this pattern matters

This separation prevents a common production issue: loading raw files directly into analytics tables without validating integrity first. By keeping raw data raw and making validation explicit, the data pipeline remains traceable, auditable, and safer for downstream reporting.

The raw-to-core pattern also ensures that the organization and provider-level relationships, especially the evidence-backed relationships in the Synthea data, can be promoted only after they are checked and confirmed.
