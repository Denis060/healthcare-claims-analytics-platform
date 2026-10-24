# Healthcare Claims Analytics Platform

> A PostgreSQL + Python data platform for claims-style healthcare analytics, built on Synthea synthetic patient data — schemas, ETL, data-quality checks, and (next) a Power BI layer.

![Python](https://img.shields.io/badge/Python-3.12-blue.svg) ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-raw%20%2B%20core%20schemas-336791.svg) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE) ![Status](https://img.shields.io/badge/status-in%20progress-orange.svg)

## Overview

This project builds the data foundation a healthcare analytics team needs before any dashboard or model: a documented warehouse schema, a repeatable ingestion pipeline, and SQL checks that prove the data is trustworthy. All data is **synthetic** (Synthea) — no PHI.

## Problem / Motivation

Questions like *where is spending concentrated, which conditions drive cost, who are the high utilizers, how often do patients return within 30 days* can only be answered reliably if the underlying claims and encounter data is modeled and validated first. This repo focuses on that layer.

## Approach & tech stack

| Layer | What's in the repo |
|---|---|
| Source profiling | `src/quality/profile_source_data.py` → `docs/source_profile/` (report + summary CSV) |
| Schema design | `sql/ddl/000_create_raw_schema.sql` (raw landing tables), `sql/ddl/001_create_core_schema.sql` (modeled core) |
| Ingestion (ETL) | `src/etl/load_raw_data.py` — validates source files and required columns, preserves IDs exactly, loads each CSV into its raw table (CLI with table selection) |
| Data quality | `sql/quality/fk_validation_checks.sql`, `sql/quality/post_load_reconciliation.sql` |
| Analytics SQL | `sql/analytics/uhf_sql_programming_sample.sql` (CTEs, joins, window functions) |
| Docs | Architecture, data architecture, data dictionary, schema relationships in `docs/` |
| CI | GitHub Actions running `pytest` on Python 3.12 |

**Stack:** Python (pandas, SQLAlchemy, psycopg2), PostgreSQL, SQL, GitHub Actions · Power BI planned.

## Key features

- Two-tier warehouse design (raw → core) with documented relationships
- Defensive loader: missing-file and missing-column checks, ID preservation, load timestamps
- Foreign-key validation and post-load row reconciliation in SQL
- Source data profiling report checked into the repo

## Status

| Done | In progress / next |
|---|---|
| Repo architecture, docs, data dictionary | Core-schema transforms |
| Synthea source profiling | Cost & utilization analysis (30-day readmits, high-cost cohorts) |
| Raw + core DDL | KPI layer and Power BI dashboard |
| Raw-layer ETL loader, SQL quality checks | Optional predictive modeling |

## How to run

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env            # set your PostgreSQL connection
psql -f sql/ddl/000_create_raw_schema.sql
psql -f sql/ddl/001_create_core_schema.sql
# put Synthea CSVs in data/raw/, then:
python -m src.etl.load_raw_data --help
psql -f sql/quality/fk_validation_checks.sql
```

## Data privacy

Synthetic data only. No real patient information is, or should be, committed.

---

## About the author

**Ibrahim Denis Fofanah** — Data Scientist · ML / GenAI (RAG, agents) · BI & analytics · MS Data Science, Pace University (2025)

[LinkedIn](https://www.linkedin.com/in/ibrahim-denis-fofanah/) · [Email](mailto:ibrahim.fofanah.ds@gmail.com) · [Live RAG portfolio project](https://moijey-copilot.vercel.app) · [GitHub](https://github.com/Denis060)
