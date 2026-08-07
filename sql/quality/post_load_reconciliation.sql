-- Post-load row-count reconciliation for raw Synthea CSV ingestion.
-- Compare raw table row counts to the expected counts from the source CSV files.
-- Run this after the CSVs are loaded into raw.* and before promotion to core.*.

WITH expected AS (
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
actual AS (
    SELECT
        table_schema || '.' || table_name AS table_name,
        COUNT(*) AS actual_rows
    FROM information_schema.tables
    WHERE table_schema = 'raw'
      AND table_name IN (
          'patients',
          'encounters',
          'conditions',
          'procedures',
          'claims',
          'claims_transactions',
          'providers',
          'payers',
          'organizations'
      )
    GROUP BY table_schema, table_name
)
SELECT
    e.table_name,
    e.expected_rows,
    COALESCE(a.actual_rows, 0) AS actual_rows,
    CASE
        WHEN COALESCE(a.actual_rows, 0) = e.expected_rows THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS reconciliation_status,
    CASE
        WHEN COALESCE(a.actual_rows, 0) = e.expected_rows THEN 0
        ELSE ABS(COALESCE(a.actual_rows, 0) - e.expected_rows)
    END AS row_delta
FROM expected e
LEFT JOIN actual a
    ON a.table_name = e.table_name
ORDER BY e.table_name;

-- Optional strict validation for automated CI or pipeline checks:
-- SELECT COUNT(*) = 0 AS has_mismatches
-- FROM (
--     WITH expected AS (
--         SELECT * FROM (VALUES
--             ('raw.patients', 108),
--             ('raw.encounters', 5473),
--             ('raw.conditions', 3784),
--             ('raw.procedures', 15985),
--             ('raw.claims', 9995),
--             ('raw.claims_transactions', 91071),
--             ('raw.providers', 278),
--             ('raw.payers', 10),
--             ('raw.organizations', 278)
--         ) AS v(table_name, expected_rows)
--     ), actual AS (
--         SELECT 
--             table_schema || '.' || table_name AS table_name,
--             COUNT(*) AS actual_rows
--         FROM information_schema.tables
--         WHERE table_schema = 'raw'
--         GROUP BY table_schema, table_name
--     )
--     SELECT e.table_name
--     FROM expected e
--     LEFT JOIN actual a ON a.table_name = e.table_name
--     WHERE COALESCE(a.actual_rows, 0) <> e.expected_rows
-- ) AS mismatches;
