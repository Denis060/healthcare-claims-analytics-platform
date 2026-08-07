/*
================================================================================
Healthcare Claims Analytics — SQL Programming Sample
United Hospital Fund application portfolio sample
Author: Ibrahim Denis Fofanah
Database: PostgreSQL
Data: Synthea synthetic healthcare data
================================================================================

BUSINESS QUESTION
-----------------
How can claims and encounter data be transformed into a reproducible,
analysis-ready patient-level dataset that identifies high-cost and
high-utilization populations for further quality-improvement analysis?

WHAT THIS SAMPLE DEMONSTRATES
-----------------------------
- Multi-table SQL transformations using CTEs
- Healthcare claims and encounter joins
- Window functions (LAG, NTILE)
- 30-day return logic
- Cost and utilization aggregation
- Patient segmentation
- Explicit handling of NULL values
- Reproducible, documented analytical logic

IMPORTANT ASSUMPTIONS
---------------------
1. This project uses synthetic Synthea data only; no real patient PHI is used.
2. Encounter TOTAL_CLAIM_COST is used as the primary cost measure because it is
   an explicit encounter-level claim-cost field in this Synthea export.
3. Claims-transactions AMOUNT/PAYMENTS/ADJUSTMENTS are summarized separately
   and are NOT treated as interchangeable with encounter TOTAL_CLAIM_COST.
4. A "30-day return" means a subsequent encounter beginning within 30 days of
   the prior encounter for the same patient. It is not labeled a clinical
   readmission because this sample does not impose additional clinical criteria.
5. PATIENTINSURANCEID in claims_transactions is intentionally not joined to
   raw.payers: validation showed it does not match payer IDs in this export.
6. The query reads from the validated raw layer so it can be executed before
   the broader portfolio project's curated/core promotion is complete.
================================================================================
*/

WITH patient_base AS (
    SELECT
        p."Id" AS patient_id,
        p."BIRTHDATE" AS birth_date,
        p."DEATHDATE" AS death_date,
        p."GENDER" AS gender,
        p."RACE" AS race,
        p."ETHNICITY" AS ethnicity,
        p."CITY" AS city,
        p."STATE" AS state,
        p."COUNTY" AS county,
        p."INCOME" AS income,
        COALESCE(p."HEALTHCARE_EXPENSES", 0) AS lifetime_healthcare_expenses,
        COALESCE(p."HEALTHCARE_COVERAGE", 0) AS lifetime_healthcare_coverage
    FROM raw.patients p
),

/* Sequence encounters within each patient so we can calculate return timing. */
encounter_sequence AS (
    SELECT
        e."Id" AS encounter_id,
        e."PATIENT" AS patient_id,
        e."START" AS encounter_start,
        e."STOP" AS encounter_stop,
        e."ENCOUNTERCLASS" AS encounter_class,
        e."ORGANIZATION" AS organization_id,
        e."PROVIDER" AS provider_id,
        e."PAYER" AS payer_id,
        COALESCE(e."BASE_ENCOUNTER_COST", 0) AS base_encounter_cost,
        COALESCE(e."TOTAL_CLAIM_COST", 0) AS total_claim_cost,
        COALESCE(e."PAYER_COVERAGE", 0) AS payer_coverage,
        LAG(e."START") OVER (
            PARTITION BY e."PATIENT"
            ORDER BY e."START", e."Id"
        ) AS prior_encounter_start
    FROM raw.encounters e
),

/* Add a conservative 30-day RETURN flag; this is not called a readmission. */
encounter_enriched AS (
    SELECT
        es.*,
        CASE
            WHEN es.prior_encounter_start IS NOT NULL
             AND es.encounter_start >= es.prior_encounter_start
             AND es.encounter_start <= es.prior_encounter_start + INTERVAL '30 days'
            THEN 1
            ELSE 0
        END AS return_within_30_days
    FROM encounter_sequence es
),

encounter_stats AS (
    SELECT
        ee.patient_id,
        COUNT(*) AS encounter_count,
        COUNT(*) FILTER (
            WHERE LOWER(COALESCE(ee.encounter_class, '')) IN ('emergency', 'urgentcare')
        ) AS emergency_or_urgent_encounters,
        COUNT(*) FILTER (
            WHERE LOWER(COALESCE(ee.encounter_class, '')) = 'inpatient'
        ) AS inpatient_encounters,
        COUNT(*) FILTER (
            WHERE LOWER(COALESCE(ee.encounter_class, '')) IN ('ambulatory', 'outpatient', 'wellness')
        ) AS ambulatory_or_outpatient_encounters,
        SUM(ee.return_within_30_days) AS returns_within_30_days,
        COUNT(DISTINCT ee.organization_id) AS organizations_used,
        COUNT(DISTINCT ee.provider_id) AS providers_used,
        COUNT(DISTINCT ee.payer_id) AS payers_used,
        ROUND(SUM(ee.base_encounter_cost), 2) AS total_base_encounter_cost,
        ROUND(SUM(ee.total_claim_cost), 2) AS total_claim_cost,
        ROUND(AVG(ee.total_claim_cost), 2) AS avg_claim_cost_per_encounter,
        ROUND(SUM(ee.payer_coverage), 2) AS total_payer_coverage,
        MIN(ee.encounter_start) AS first_encounter_at,
        MAX(ee.encounter_start) AS most_recent_encounter_at
    FROM encounter_enriched ee
    GROUP BY ee.patient_id
),

condition_stats AS (
    SELECT
        c."PATIENT" AS patient_id,
        COUNT(*) AS condition_records,
        COUNT(DISTINCT c."CODE") AS distinct_condition_codes,
        COUNT(DISTINCT c."ENCOUNTER") AS encounters_with_conditions,
        COUNT(*) FILTER (WHERE c."STOP" IS NULL) AS active_condition_records
    FROM raw.conditions c
    GROUP BY c."PATIENT"
),

procedure_stats AS (
    SELECT
        pr."PATIENT" AS patient_id,
        COUNT(*) AS procedure_count,
        COUNT(DISTINCT pr."CODE") AS distinct_procedure_codes,
        COUNT(DISTINCT pr."ENCOUNTER") AS encounters_with_procedures,
        ROUND(SUM(COALESCE(pr."BASE_COST", 0)), 2) AS total_procedure_base_cost,
        ROUND(AVG(COALESCE(pr."BASE_COST", 0)), 2) AS avg_procedure_base_cost
    FROM raw.procedures pr
    GROUP BY pr."PATIENT"
),

claim_stats AS (
    SELECT
        c."PATIENTID" AS patient_id,
        COUNT(*) AS claim_count,
        COUNT(DISTINCT c."PROVIDERID") AS claim_providers,
        COUNT(DISTINCT c."PRIMARYPATIENTINSURANCEID") FILTER (
            WHERE c."PRIMARYPATIENTINSURANCEID" IS NOT NULL
        ) AS primary_insurance_ids,
        COUNT(*) FILTER (WHERE c."DIAGNOSIS1" IS NOT NULL) AS claims_with_primary_diagnosis,
        ROUND(SUM(
            COALESCE(c."OUTSTANDING1", 0)
          + COALESCE(c."OUTSTANDING2", 0)
          + COALESCE(c."OUTSTANDINGP", 0)
        ), 2) AS total_claim_outstanding
    FROM raw.claims c
    GROUP BY c."PATIENTID"
),

/*
Claims transaction values are kept as their own accounting measures rather
than being mixed with encounter TOTAL_CLAIM_COST.
*/
transaction_stats AS (
    SELECT
        ct."PATIENTID" AS patient_id,
        COUNT(*) AS claim_transaction_count,
        COUNT(DISTINCT ct."CLAIMID") AS claims_with_transactions,
        COUNT(DISTINCT ct."PROCEDURECODE") FILTER (
            WHERE ct."PROCEDURECODE" IS NOT NULL
        ) AS transaction_procedure_codes,
        ROUND(SUM(COALESCE(ct."AMOUNT", 0)), 2) AS gross_transaction_amount,
        ROUND(SUM(COALESCE(ct."PAYMENTS", 0)), 2) AS transaction_payments,
        ROUND(SUM(COALESCE(ct."ADJUSTMENTS", 0)), 2) AS transaction_adjustments,
        ROUND(SUM(COALESCE(ct."TRANSFERS", 0)), 2) AS transaction_transfers,
        ROUND(SUM(COALESCE(ct."OUTSTANDING", 0)), 2) AS transaction_outstanding
    FROM raw.claims_transactions ct
    GROUP BY ct."PATIENTID"
),

/* Create one analysis-ready row per patient. */
patient_analytic_base AS (
    SELECT
        pb.patient_id,
        pb.birth_date,
        pb.death_date,
        pb.gender,
        pb.race,
        pb.ethnicity,
        pb.city,
        pb.state,
        pb.county,
        pb.income,
        pb.lifetime_healthcare_expenses,
        pb.lifetime_healthcare_coverage,

        COALESCE(es.encounter_count, 0) AS encounter_count,
        COALESCE(es.emergency_or_urgent_encounters, 0) AS emergency_or_urgent_encounters,
        COALESCE(es.inpatient_encounters, 0) AS inpatient_encounters,
        COALESCE(es.ambulatory_or_outpatient_encounters, 0) AS ambulatory_or_outpatient_encounters,
        COALESCE(es.returns_within_30_days, 0) AS returns_within_30_days,
        COALESCE(es.organizations_used, 0) AS organizations_used,
        COALESCE(es.providers_used, 0) AS providers_used,
        COALESCE(es.payers_used, 0) AS payers_used,
        COALESCE(es.total_base_encounter_cost, 0) AS total_base_encounter_cost,
        COALESCE(es.total_claim_cost, 0) AS total_claim_cost,
        COALESCE(es.avg_claim_cost_per_encounter, 0) AS avg_claim_cost_per_encounter,
        COALESCE(es.total_payer_coverage, 0) AS total_payer_coverage,
        es.first_encounter_at,
        es.most_recent_encounter_at,

        COALESCE(cs.condition_records, 0) AS condition_records,
        COALESCE(cs.distinct_condition_codes, 0) AS distinct_condition_codes,
        COALESCE(cs.encounters_with_conditions, 0) AS encounters_with_conditions,
        COALESCE(cs.active_condition_records, 0) AS active_condition_records,

        COALESCE(ps.procedure_count, 0) AS procedure_count,
        COALESCE(ps.distinct_procedure_codes, 0) AS distinct_procedure_codes,
        COALESCE(ps.encounters_with_procedures, 0) AS encounters_with_procedures,
        COALESCE(ps.total_procedure_base_cost, 0) AS total_procedure_base_cost,
        COALESCE(ps.avg_procedure_base_cost, 0) AS avg_procedure_base_cost,

        COALESCE(cls.claim_count, 0) AS claim_count,
        COALESCE(cls.claim_providers, 0) AS claim_providers,
        COALESCE(cls.primary_insurance_ids, 0) AS primary_insurance_ids,
        COALESCE(cls.claims_with_primary_diagnosis, 0) AS claims_with_primary_diagnosis,
        COALESCE(cls.total_claim_outstanding, 0) AS total_claim_outstanding,

        COALESCE(ts.claim_transaction_count, 0) AS claim_transaction_count,
        COALESCE(ts.claims_with_transactions, 0) AS claims_with_transactions,
        COALESCE(ts.transaction_procedure_codes, 0) AS transaction_procedure_codes,
        COALESCE(ts.gross_transaction_amount, 0) AS gross_transaction_amount,
        COALESCE(ts.transaction_payments, 0) AS transaction_payments,
        COALESCE(ts.transaction_adjustments, 0) AS transaction_adjustments,
        COALESCE(ts.transaction_transfers, 0) AS transaction_transfers,
        COALESCE(ts.transaction_outstanding, 0) AS transaction_outstanding
    FROM patient_base pb
    LEFT JOIN encounter_stats es
        ON es.patient_id = pb.patient_id
    LEFT JOIN condition_stats cs
        ON cs.patient_id = pb.patient_id
    LEFT JOIN procedure_stats ps
        ON ps.patient_id = pb.patient_id
    LEFT JOIN claim_stats cls
        ON cls.patient_id = pb.patient_id
    LEFT JOIN transaction_stats ts
        ON ts.patient_id = pb.patient_id
),

/* Rank patients independently by cost and utilization. */
patient_ranked AS (
    SELECT
        pab.*,
        NTILE(10) OVER (
            ORDER BY pab.total_claim_cost DESC, pab.patient_id
        ) AS cost_decile,
        NTILE(10) OVER (
            ORDER BY pab.encounter_count DESC, pab.patient_id
        ) AS utilization_decile,
        PERCENT_RANK() OVER (
            ORDER BY pab.total_claim_cost
        ) AS cost_percentile
    FROM patient_analytic_base pab
)

SELECT
    pr.*,
    CASE
        WHEN pr.cost_decile = 1 THEN 'High Cost'
        WHEN pr.cost_decile <= 3 THEN 'Elevated Cost'
        ELSE 'Standard Cost'
    END AS cost_segment,
    CASE
        WHEN pr.utilization_decile = 1 THEN 'High Utilization'
        WHEN pr.utilization_decile <= 3 THEN 'Elevated Utilization'
        ELSE 'Standard Utilization'
    END AS utilization_segment,
    CASE
        WHEN pr.cost_decile = 1 AND pr.utilization_decile = 1
            THEN 'High Cost + High Utilization'
        WHEN pr.cost_decile = 1
            THEN 'High Cost'
        WHEN pr.utilization_decile = 1
            THEN 'High Utilization'
        ELSE 'Other'
    END AS priority_segment
FROM patient_ranked pr
ORDER BY
    pr.total_claim_cost DESC,
    pr.encounter_count DESC,
    pr.patient_id;
