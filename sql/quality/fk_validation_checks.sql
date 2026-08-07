WITH relationship_checks AS (
    SELECT 'raw.patients."Id" -> raw.encounters."PATIENT"' AS relationship,
           COUNT(*) AS child_rows,
           COUNT(e."PATIENT") AS non_null_child_keys,
           COUNT(p."Id") AS matched_rows,
           COUNT(*) FILTER (
               WHERE e."PATIENT" IS NOT NULL
                 AND p."Id" IS NULL
           ) AS unmatched_rows
    FROM raw.encounters e
    LEFT JOIN raw.patients p ON e."PATIENT" = p."Id"

    UNION ALL

    SELECT 'raw.patients."Id" -> raw.conditions."PATIENT"',
           COUNT(*),
           COUNT(c."PATIENT"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE c."PATIENT" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.conditions c
    LEFT JOIN raw.patients p ON c."PATIENT" = p."Id"

    UNION ALL

    SELECT 'raw.patients."Id" -> raw.procedures."PATIENT"',
           COUNT(*),
           COUNT(pr."PATIENT"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE pr."PATIENT" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.procedures pr
    LEFT JOIN raw.patients p ON pr."PATIENT" = p."Id"

    UNION ALL

    SELECT 'raw.patients."Id" -> raw.claims."PATIENTID"',
           COUNT(*),
           COUNT(cl."PATIENTID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE cl."PATIENTID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims cl
    LEFT JOIN raw.patients p ON cl."PATIENTID" = p."Id"

    UNION ALL

    SELECT 'raw.patients."Id" -> raw.claims_transactions."PATIENTID"',
           COUNT(*),
           COUNT(ct."PATIENTID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE ct."PATIENTID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims_transactions ct
    LEFT JOIN raw.patients p ON ct."PATIENTID" = p."Id"

    UNION ALL

    SELECT 'raw.encounters."Id" -> raw.conditions."ENCOUNTER"',
           COUNT(*),
           COUNT(c."ENCOUNTER"),
           COUNT(e."Id"),
           COUNT(*) FILTER (
               WHERE c."ENCOUNTER" IS NOT NULL
                 AND e."Id" IS NULL
           )
    FROM raw.conditions c
    LEFT JOIN raw.encounters e ON c."ENCOUNTER" = e."Id"

    UNION ALL

    SELECT 'raw.encounters."Id" -> raw.procedures."ENCOUNTER"',
           COUNT(*),
           COUNT(pr."ENCOUNTER"),
           COUNT(e."Id"),
           COUNT(*) FILTER (
               WHERE pr."ENCOUNTER" IS NOT NULL
                 AND e."Id" IS NULL
           )
    FROM raw.procedures pr
    LEFT JOIN raw.encounters e ON pr."ENCOUNTER" = e."Id"

    UNION ALL

    SELECT 'raw.providers."Id" -> raw.encounters."PROVIDER"',
           COUNT(*),
           COUNT(e."PROVIDER"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE e."PROVIDER" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.encounters e
    LEFT JOIN raw.providers p ON e."PROVIDER" = p."Id"

    UNION ALL

    SELECT 'raw.providers."Id" -> raw.claims."PROVIDERID"',
           COUNT(*),
           COUNT(cl."PROVIDERID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE cl."PROVIDERID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims cl
    LEFT JOIN raw.providers p ON cl."PROVIDERID" = p."Id"

    UNION ALL

    SELECT 'raw.providers."Id" -> raw.claims."REFERRINGPROVIDERID"',
           COUNT(*),
           COUNT(cl."REFERRINGPROVIDERID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE cl."REFERRINGPROVIDERID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims cl
    LEFT JOIN raw.providers p ON cl."REFERRINGPROVIDERID" = p."Id"

    UNION ALL

    SELECT 'raw.providers."Id" -> raw.claims."SUPERVISINGPROVIDERID"',
           COUNT(*),
           COUNT(cl."SUPERVISINGPROVIDERID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE cl."SUPERVISINGPROVIDERID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims cl
    LEFT JOIN raw.providers p ON cl."SUPERVISINGPROVIDERID" = p."Id"

    UNION ALL

    SELECT 'raw.providers."Id" -> raw.claims_transactions."PROVIDERID"',
           COUNT(*),
           COUNT(ct."PROVIDERID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE ct."PROVIDERID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims_transactions ct
    LEFT JOIN raw.providers p ON ct."PROVIDERID" = p."Id"

    UNION ALL

    SELECT 'raw.providers."Id" -> raw.claims_transactions."SUPERVISINGPROVIDERID"',
           COUNT(*),
           COUNT(ct."SUPERVISINGPROVIDERID"),
           COUNT(p."Id"),
           COUNT(*) FILTER (
               WHERE ct."SUPERVISINGPROVIDERID" IS NOT NULL
                 AND p."Id" IS NULL
           )
    FROM raw.claims_transactions ct
    LEFT JOIN raw.providers p ON ct."SUPERVISINGPROVIDERID" = p."Id"

    UNION ALL

    SELECT 'raw.payers."Id" -> raw.encounters."PAYER"',
           COUNT(*),
           COUNT(e."PAYER"),
           COUNT(py."Id"),
           COUNT(*) FILTER (
               WHERE e."PAYER" IS NOT NULL
                 AND py."Id" IS NULL
           )
    FROM raw.encounters e
    LEFT JOIN raw.payers py ON e."PAYER" = py."Id"

    UNION ALL

    SELECT 'raw.payers."Id" -> raw.claims."PRIMARYPATIENTINSURANCEID"',
           COUNT(*),
           COUNT(cl."PRIMARYPATIENTINSURANCEID"),
           COUNT(py."Id"),
           COUNT(*) FILTER (
               WHERE cl."PRIMARYPATIENTINSURANCEID" IS NOT NULL
                 AND py."Id" IS NULL
           )
    FROM raw.claims cl
    LEFT JOIN raw.payers py ON cl."PRIMARYPATIENTINSURANCEID" = py."Id"

    UNION ALL

    SELECT 'raw.payers."Id" -> raw.claims."SECONDARYPATIENTINSURANCEID"',
           COUNT(*),
           COUNT(cl."SECONDARYPATIENTINSURANCEID"),
           COUNT(py."Id"),
           COUNT(*) FILTER (
               WHERE cl."SECONDARYPATIENTINSURANCEID" IS NOT NULL
                 AND py."Id" IS NULL
           )
    FROM raw.claims cl
    LEFT JOIN raw.payers py ON cl."SECONDARYPATIENTINSURANCEID" = py."Id"

    UNION ALL

    SELECT 'raw.payers."Id" -> raw.claims_transactions."PATIENTINSURANCEID"',
           COUNT(*),
           COUNT(ct."PATIENTINSURANCEID"),
           COUNT(py."Id"),
           COUNT(*) FILTER (
               WHERE ct."PATIENTINSURANCEID" IS NOT NULL
                 AND py."Id" IS NULL
           )
    FROM raw.claims_transactions ct
    LEFT JOIN raw.payers py ON ct."PATIENTINSURANCEID" = py."Id"

    UNION ALL

    SELECT 'raw.claims."Id" -> raw.claims_transactions."CLAIMID"',
           COUNT(*),
           COUNT(ct."CLAIMID"),
           COUNT(c."Id"),
           COUNT(*) FILTER (
               WHERE ct."CLAIMID" IS NOT NULL
                 AND c."Id" IS NULL
           )
    FROM raw.claims_transactions ct
    LEFT JOIN raw.claims c ON ct."CLAIMID" = c."Id"

    UNION ALL

    SELECT 'raw.organizations."Id" -> raw.encounters."ORGANIZATION"',
           COUNT(*),
           COUNT(e."ORGANIZATION"),
           COUNT(o."Id"),
           COUNT(*) FILTER (
               WHERE e."ORGANIZATION" IS NOT NULL
                 AND o."Id" IS NULL
           )
    FROM raw.encounters e
    LEFT JOIN raw.organizations o ON e."ORGANIZATION" = o."Id"

    UNION ALL

    SELECT 'raw.organizations."Id" -> raw.providers."ORGANIZATION"',
           COUNT(*),
           COUNT(p."ORGANIZATION"),
           COUNT(o."Id"),
           COUNT(*) FILTER (
               WHERE p."ORGANIZATION" IS NOT NULL
                 AND o."Id" IS NULL
           )
    FROM raw.providers p
    LEFT JOIN raw.organizations o ON p."ORGANIZATION" = o."Id"
)
SELECT
    relationship,
    child_rows,
    non_null_child_keys,
    matched_rows,
    unmatched_rows,
    ROUND(100.0 * matched_rows / NULLIF(non_null_child_keys, 0), 2) AS match_rate_pct
FROM relationship_checks
ORDER BY relationship;
