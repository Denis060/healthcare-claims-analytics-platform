# Schema relationship notes for the core Synthea tables

This document summarizes the relationships that are supported by the actual source CSV structure and the source profiling results.

## Confirmed primary keys

The following tables have a confirmed unique identifier in the source data and are safe to treat as primary keys:

- patients: `Id`
- encounters: `Id`
- providers: `Id`
- payers: `Id`
- claims: `Id`
- claims_transactions: `ID`

These columns were checked for uniqueness during profiling and were either fully unique or effectively unique enough to treat as primary keys.

## Confirmed or likely foreign keys

### Patient-to-encounter relationship

- encounters.patient -> patients.id
- Source columns: `PATIENT` in encounters.csv and `Id` in patients.csv
- This relationship is strongly supported because the PATIENT values match the patient identifier format used throughout the dataset.

### Encounter-to-condition/procedure relationship

- conditions.encounter -> encounters.id
- procedures.encounter -> encounters.id
- Source columns: `ENCOUNTER` in conditions.csv and procedures.csv; `Id` in encounters.csv
- This relationship is strongly supported by value matching and the event semantics of the two tables.

### Patient-to-condition/procedure relationship

- conditions.patient -> patients.id
- procedures.patient -> patients.id
- Source columns: `PATIENT` in both files and `Id` in patients.csv
- This is confirmed by repeated matching patient identifiers across the dataset.

### Claim-to-claim-transaction relationship

- claims_transactions.claim_id -> claims.id
- Source columns: `CLAIMID` in claims_transactions.csv and `Id` in claims.csv
- This is one of the clearest relationships in the model because each transaction belongs to exactly one claim, and the relationship name lines up directly with the source column names.

### Claim-to-patient relationship

- claims.patient_id -> patients.id
- claims_transactions.patient_id -> patients.id
- Source columns: `PATIENTID` in claims.csv and claims_transactions.csv; `Id` in patients.csv
- This relationship is strongly supported by repeated patient values across all patient-facing event tables.

### Provider links

- encounters.provider_id -> providers.id
- claims.provider_id -> providers.id
- claims.referring_provider_id -> providers.id
- claims.supervising_provider_id -> providers.id
- claims_transactions.provider_id -> providers.id
- claims_transactions.supervising_provider_id -> providers.id
- Source columns use provider identifiers directly in the raw CSV and match the provider table.

### Payer links

- encounters.payer_id -> payers.id
- claims.primary_patient_insurance_id -> payers.id
- claims.secondary_patient_insurance_id -> payers.id
- Source columns include payer identifiers and match the payer dimension table.

The following relationship is intentionally not enforced in the raw-to-core model:

- claims_transactions.patient_insurance_id -> payers.id
- This field is retained as a source attribute because the observed match rate is effectively 0% in the raw export and does not represent the payer master key for this dataset.

## Unresolved or intentionally excluded relationships

These are not modeled as foreign keys in the proposed DDL because they are not as strongly supported or because the target table is not part of the initial core schema.

- claims.referring_provider_id -> providers.id
  - This relationship remains unconstrained because the raw source contains no non-null values in `REFERRINGPROVIDERID`; there is no usable validation set to enforce this key.

- encounters.organization -> organizations table
  - There is an `ORGANIZATION` column in encounters.csv and an `ORGANIZATION` field in providers.csv, but the repository does not yet include a modeled organizations table in the initial core schema.
  - This relationship should be validated before adding a table-level foreign key.

- providers.organization_id -> organizations.id
  - Same as above; source values look like UUIDs and are likely organization identifiers, but the corresponding organizations dimension is not part of this schema yet.

- claims.department_id and claims.patient_department_id
  - These likely refer to department dimensions, but no department table is included in the initial DDL.
  - They are retained as integer columns until a department dimension is designed.

- claims_transactions.transferout_id
  - The column name suggests a transfer target, but the target object type is ambiguous and the source does not clearly define a corresponding table.
  - This relationship remains unresolved and should not be enforced as a foreign key without further validation.

- claims_transactions.appointment_id
  - This appears to reference appointment data, but there is no appointment table yet in the schema.
  - It is left as a nullable UUID column for later validation.

## Relationships that remain ambiguous

These should be validated before the DDL is executed in production:

1. Organization references
   - `encounters.organization_id` and `providers.organization_id` likely point to an `organizations` table, but the organizations CSV was not included in the scope for the initial core schema.

2. Insurance coverage columns on claims and transactions
   - `primary_patient_insurance_id`, `secondary_patient_insurance_id`, and `patient_insurance_id` are strongly suggestive of payer references, but they should be checked against payer transitions and coverage logic before strict enforcement.

3. Department dimensions
   - `department_id` and `patient_department_id` likely map to a dimension table outside the current dataset, but that mapping is not explicit enough to model safely in the first DDL.

4. Transfer ID semantics
   - `transferout_id` is not tied to an identifiable target object in the current source data and should be treated as an unresolved reference until the underlying business meaning is clarified.

## Summary

The strongest, safest initial relational model is:

- patients to encounters, conditions, procedures, claims, and transactions
- encounters to conditions and procedures
- claims to patient/provider/payer references
- claims_transactions to claims, patient, provider, and payer references
- providers to encounters and claims by provider IDs

These are the relationships that match the source data most directly and are appropriate for the first version of the PostgreSQL schema.
