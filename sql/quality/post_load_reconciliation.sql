-- Post-load row-count reconciliation for raw Synthea CSV ingestion.
-- Compare actual raw table row counts to the expected counts from the source CSV files.
-- Run this after the CSVs are loaded into raw.* and before promotion to core.*.

WITH expected_counts AS (
    SELECT * FROM (VALUES
        ('raw.patients', 108),
        ('raw.encounters', 5473),
        ('raw.conditions', 3784),
        ('raw.procedures', 15985),
        ('raw.claims', 9995),
        ('raw.claims_transactions', 91071),
        ('raw.providers', 278),
        ('raw.payers', 10),
        ('raw.organizations', 278)
    ) AS v(table_name, expected_rows)
),
actual_counts AS (
    SELECT 'raw.patients' AS table_name, 108 AS expected_rows, COUNT(*) AS actual_rows FROM raw.patients
    UNION ALL
    SELECT 'raw.encounters', 5473, COUNT(*) FROM raw.encounters
    UNION ALL
    SELECT 'raw.conditions', 3784, COUNT(*) FROM raw.conditions
    UNION ALL
    SELECT 'raw.procedures', 15985, COUNT(*) FROM raw.procedures
    UNION ALL
    SELECT 'raw.claims', 9995, COUNT(*) FROM raw.claims
    UNION ALL
    SELECT 'raw.claims_transactions', 91071, COUNT(*) FROM raw.claims_transactions
    UNION ALL
    SELECT 'raw.providers', 278, COUNT(*) FROM raw.providers
    UNION ALL
    SELECT 'raw.payers', 10, COUNT(*) FROM raw.payers
    UNION ALL
    SELECT 'raw.organizations', 278, COUNT(*) FROM raw.organizations
),
comparison AS (
    SELECT
        e.table_name,
        e.expected_rows,
        a.actual_rows,
        CASE WHEN a.actual_rows = e.expected_rows THEN 'PASS' ELSE 'FAIL' END AS status,
        ABS(a.actual_rows - e.expected_rows) AS row_delta
    FROM expected_counts e
    INNER JOIN actual_counts a
        ON a.table_name = e.table_name
),
summary AS (
    SELECT
        'OVERALL SUMMARY' AS table_name,
        SUM(expected_rows) AS expected_rows,
        SUM(actual_rows) AS actual_rows,
        CASE WHEN SUM(actual_rows) = SUM(expected_rows) THEN 'PASS' ELSE 'FAIL' END AS status,
        ABS(SUM(actual_rows) - SUM(expected_rows)) AS row_delta
    FROM comparison
)
SELECT
    table_name,
    expected_rows,
    actual_rows,
    status,
    row_delta
FROM comparison
UNION ALL
SELECT
    table_name,
    expected_rows,
    actual_rows,
    status,
    row_delta
FROM summary
ORDER BY table_name;
