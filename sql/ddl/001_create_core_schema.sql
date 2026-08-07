-- Curated core layer for healthcare claims analytics.
-- Raw data is ingested into raw.* first, then validated before promotion into the curated core layer.

CREATE SCHEMA IF NOT EXISTS core;

DROP TABLE IF EXISTS core.claims_transactions;
DROP TABLE IF EXISTS core.claims;
DROP TABLE IF EXISTS core.procedures;
DROP TABLE IF EXISTS core.conditions;
DROP TABLE IF EXISTS core.encounters;
DROP TABLE IF EXISTS core.providers;
DROP TABLE IF EXISTS core.patients;
DROP TABLE IF EXISTS core.payers;
DROP TABLE IF EXISTS core.organizations;

CREATE TABLE core.organizations (
    id UUID PRIMARY KEY,
    name TEXT NOT NULL,
    address TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    lat NUMERIC(12, 8),
    lon NUMERIC(12, 8),
    phone TEXT,
    revenue NUMERIC(18, 2),
    utilization INTEGER
);

CREATE TABLE core.patients (
    id UUID PRIMARY KEY,
    birthdate DATE,
    deathdate DATE,
    ssn TEXT,
    drivers TEXT,
    passport TEXT,
    prefix TEXT,
    first_name TEXT,
    middle_name TEXT,
    last_name TEXT,
    suffix TEXT,
    maiden TEXT,
    marital TEXT,
    race TEXT,
    ethnicity TEXT,
    gender TEXT,
    birthplace TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    county TEXT,
    fips INTEGER,
    zip TEXT,
    lat NUMERIC(12, 8),
    lon NUMERIC(12, 8),
    healthcare_expenses NUMERIC(18, 2),
    healthcare_coverage NUMERIC(18, 2),
    income INTEGER
);

CREATE TABLE core.providers (
    id UUID PRIMARY KEY,
    organization_id UUID,
    name TEXT,
    gender TEXT,
    specialty TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    zip TEXT,
    lat NUMERIC(12, 8),
    lon NUMERIC(12, 8),
    encounters INTEGER,
    procedures INTEGER,
    CONSTRAINT fk_providers_organization
        FOREIGN KEY (organization_id)
        REFERENCES core.organizations (id)
);

CREATE TABLE core.payers (
    id UUID PRIMARY KEY,
    name TEXT,
    ownership TEXT,
    address TEXT,
    city TEXT,
    state_headquartered TEXT,
    zip TEXT,
    phone TEXT,
    amount_covered NUMERIC(18, 2),
    amount_uncovered NUMERIC(18, 2),
    revenue NUMERIC(18, 2),
    covered_encounters INTEGER,
    uncovered_encounters INTEGER,
    covered_medications INTEGER,
    uncovered_medications INTEGER,
    covered_procedures INTEGER,
    uncovered_procedures INTEGER,
    covered_immunizations INTEGER,
    uncovered_immunizations INTEGER,
    unique_customers INTEGER,
    qols_avg NUMERIC(10, 6),
    member_months INTEGER
);

CREATE TABLE core.encounters (
    id UUID PRIMARY KEY,
    start_at TIMESTAMPTZ,
    stop_at TIMESTAMPTZ,
    patient_id UUID NOT NULL,
    organization_id UUID,
    provider_id UUID,
    payer_id UUID,
    encounter_class TEXT,
    code TEXT,
    description TEXT,
    base_encounter_cost NUMERIC(18, 2),
    total_claim_cost NUMERIC(18, 2),
    payer_coverage NUMERIC(18, 2),
    reasoncode TEXT,
    reasondescription TEXT,
    CONSTRAINT fk_encounters_patient
        FOREIGN KEY (patient_id)
        REFERENCES core.patients (id),
    CONSTRAINT fk_encounters_organization
        FOREIGN KEY (organization_id)
        REFERENCES core.organizations (id),
    CONSTRAINT fk_encounters_provider
        FOREIGN KEY (provider_id)
        REFERENCES core.providers (id),
    CONSTRAINT fk_encounters_payer
        FOREIGN KEY (payer_id)
        REFERENCES core.payers (id)
);

CREATE TABLE core.conditions (
    id BIGSERIAL PRIMARY KEY,
    start_date DATE,
    stop_date DATE,
    patient_id UUID NOT NULL,
    encounter_id UUID,
    system TEXT,
    code TEXT,
    description TEXT,
    CONSTRAINT fk_conditions_patient
        FOREIGN KEY (patient_id)
        REFERENCES core.patients (id),
    CONSTRAINT fk_conditions_encounter
        FOREIGN KEY (encounter_id)
        REFERENCES core.encounters (id)
);

CREATE TABLE core.procedures (
    id BIGSERIAL PRIMARY KEY,
    start_at TIMESTAMPTZ,
    stop_at TIMESTAMPTZ,
    patient_id UUID NOT NULL,
    encounter_id UUID,
    system TEXT,
    code TEXT,
    description TEXT,
    base_cost NUMERIC(18, 2),
    reasoncode TEXT,
    reasondescription TEXT,
    CONSTRAINT fk_procedures_patient
        FOREIGN KEY (patient_id)
        REFERENCES core.patients (id),
    CONSTRAINT fk_procedures_encounter
        FOREIGN KEY (encounter_id)
        REFERENCES core.encounters (id)
);

CREATE TABLE core.claims (
    id UUID PRIMARY KEY,
    patient_id UUID NOT NULL,
    provider_id UUID,
    primary_patient_insurance_id UUID,
    secondary_patient_insurance_id UUID,
    department_id INTEGER,
    patient_department_id INTEGER,
    diagnosis1 TEXT,
    diagnosis2 TEXT,
    diagnosis3 TEXT,
    diagnosis4 TEXT,
    diagnosis5 TEXT,
    diagnosis6 TEXT,
    diagnosis7 TEXT,
    diagnosis8 TEXT,
    referring_provider_id UUID,
    appointment_id UUID,
    current_illness_date TIMESTAMPTZ,
    service_date TIMESTAMPTZ,
    supervising_provider_id UUID,
    status1 TEXT,
    status2 TEXT,
    statusp TEXT,
    outstanding1 NUMERIC(18, 2),
    outstanding2 NUMERIC(18, 2),
    outstandingp NUMERIC(18, 2),
    last_billed_date1 TIMESTAMPTZ,
    last_billed_date2 TIMESTAMPTZ,
    last_billed_datep TIMESTAMPTZ,
    healthcare_claim_type_id1 INTEGER,
    healthcare_claim_type_id2 INTEGER,
    CONSTRAINT fk_claims_patient
        FOREIGN KEY (patient_id)
        REFERENCES core.patients (id),
    CONSTRAINT fk_claims_provider
        FOREIGN KEY (provider_id)
        REFERENCES core.providers (id),
    CONSTRAINT fk_claims_primary_insurance
        FOREIGN KEY (primary_patient_insurance_id)
        REFERENCES core.payers (id),
    CONSTRAINT fk_claims_secondary_insurance
        FOREIGN KEY (secondary_patient_insurance_id)
        REFERENCES core.payers (id),
    CONSTRAINT fk_claims_supervising_provider
        FOREIGN KEY (supervising_provider_id)
        REFERENCES core.providers (id)
);

CREATE TABLE core.claims_transactions (
    id UUID PRIMARY KEY,
    claim_id UUID NOT NULL,
    charge_id BIGINT,
    patient_id UUID NOT NULL,
    type TEXT,
    amount NUMERIC(18, 2),
    method TEXT,
    fromdate TIMESTAMPTZ,
    todate TIMESTAMPTZ,
    place_of_service TEXT,
    procedure_code TEXT,
    modifier1 TEXT,
    modifier2 TEXT,
    diagnosisref1 TEXT,
    diagnosisref2 TEXT,
    diagnosisref3 TEXT,
    diagnosisref4 TEXT,
    units INTEGER,
    department_id INTEGER,
    notes TEXT,
    unitamount NUMERIC(18, 2),
    transferout_id UUID,
    transfertype TEXT,
    payments NUMERIC(18, 2),
    adjustments NUMERIC(18, 2),
    transfers NUMERIC(18, 2),
    outstanding NUMERIC(18, 2),
    appointment_id UUID,
    linenote TEXT,
    patient_insurance_id UUID,
    feeschedule_id INTEGER,
    provider_id UUID,
    supervising_provider_id UUID,
    CONSTRAINT fk_claims_transactions_claim
        FOREIGN KEY (claim_id)
        REFERENCES core.claims (id),
    CONSTRAINT fk_claims_transactions_patient
        FOREIGN KEY (patient_id)
        REFERENCES core.patients (id),
    CONSTRAINT fk_claims_transactions_provider
        FOREIGN KEY (provider_id)
        REFERENCES core.providers (id),
    CONSTRAINT fk_claims_transactions_supervising_provider
        FOREIGN KEY (supervising_provider_id)
        REFERENCES core.providers (id)
);

CREATE INDEX idx_core_encounters_patient_id ON core.encounters (patient_id);
CREATE INDEX idx_core_encounters_organization_id ON core.encounters (organization_id);
CREATE INDEX idx_core_encounters_provider_id ON core.encounters (provider_id);
CREATE INDEX idx_core_encounters_payer_id ON core.encounters (payer_id);
CREATE INDEX idx_core_conditions_patient_id ON core.conditions (patient_id);
CREATE INDEX idx_core_conditions_encounter_id ON core.conditions (encounter_id);
CREATE INDEX idx_core_procedures_patient_id ON core.procedures (patient_id);
CREATE INDEX idx_core_procedures_encounter_id ON core.procedures (encounter_id);
CREATE INDEX idx_core_claims_patient_id ON core.claims (patient_id);
CREATE INDEX idx_core_claims_provider_id ON core.claims (provider_id);
CREATE INDEX idx_core_claims_primary_insurance_id ON core.claims (primary_patient_insurance_id);
CREATE INDEX idx_core_claims_secondary_insurance_id ON core.claims (secondary_patient_insurance_id);
CREATE INDEX idx_core_claims_referring_provider_id ON core.claims (referring_provider_id);
CREATE INDEX idx_core_claims_supervising_provider_id ON core.claims (supervising_provider_id);
CREATE INDEX idx_core_claims_transactions_claim_id ON core.claims_transactions (claim_id);
CREATE INDEX idx_core_claims_transactions_patient_id ON core.claims_transactions (patient_id);
CREATE INDEX idx_core_claims_transactions_provider_id ON core.claims_transactions (provider_id);
CREATE INDEX idx_core_claims_transactions_supervising_provider_id ON core.claims_transactions (supervising_provider_id);
CREATE INDEX idx_core_claims_transactions_patient_insurance_id ON core.claims_transactions (patient_insurance_id);
CREATE INDEX idx_core_providers_organization_id ON core.providers (organization_id);
CREATE INDEX idx_core_payers_name ON core.payers (name);
CREATE INDEX idx_core_organizations_name ON core.organizations (name);
