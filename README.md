# Healthcare Claims Analytics & Population Health Intelligence Platform

A portfolio project for learning and demonstrating healthcare analytics, SQL, data engineering, data quality, business intelligence, and population-health analysis using synthetic healthcare data.

## Project goals

This project is designed to answer practical healthcare questions such as:

- Where is healthcare spending concentrated?
- Which conditions and procedures drive the most cost?
- Which patients have the highest utilization?
- What share of total spending is driven by high-cost patient groups?
- How frequently are patients returning within 30 days?
- Which segments may benefit from targeted intervention?

## Why this project exists

Healthcare analytics roles frequently require experience working with claims or other administrative health data, advanced SQL, ETL/data transformation, data quality, documentation, and dashboards. This repository is being built publicly as both a portfolio project and an educational series.

## Planned stack

- **Data:** Synthea synthetic healthcare data
- **Database:** PostgreSQL
- **Programming:** Python
- **Analytics:** SQL
- **Visualization:** Power BI
- **Version control:** Git/GitHub
- **Testing & quality:** SQL validation checks + Python tests

## Repository structure

```text
healthcare-claims-analytics-platform/
├── data/
│   ├── raw/                 # Source data (not committed)
│   └── processed/           # Derived datasets (not committed)
├── docs/                    # Architecture, data dictionary, decisions
├── notebooks/               # Exploration only; production logic moves to src/sql
├── sql/
│   ├── ddl/                 # Database/table definitions
│   ├── etl/                 # SQL transformations
│   ├── analytics/           # Business-facing analytical queries
│   └── quality/             # Data-quality checks
├── src/
│   ├── etl/                 # Python ingestion/transformation code
│   ├── quality/             # Data-quality utilities
│   └── utils/               # Shared helpers
├── dashboard/               # Power BI assets/screenshots
├── tests/                   # Automated tests
└── .github/workflows/       # CI workflows
```

## Build roadmap

1. Healthcare claims fundamentals
2. Understand the Synthea dataset
3. Design the healthcare database
4. Build the ingestion/ETL pipeline
5. Validate data quality
6. Develop advanced SQL transformations
7. Analyze cost, utilization, and patient segments
8. Build healthcare KPIs
9. Create the Power BI dashboard
10. Translate findings into recommendations
11. Add optional predictive modeling
12. Publish portfolio documentation and SQL programming sample

## Project Status

✅ Repository architecture established  
✅ Healthcare analytics requirements defined  
✅ Data-quality framework designed  
🔄 Synthea dataset profiling  
⬜ PostgreSQL schema  
⬜ ETL pipeline  
⬜ Advanced claims SQL analysis  
⬜ Healthcare KPI layer  
⬜ Power BI dashboard  
⬜ Predictive modeling

## SQL programming sample

A dedicated SQL sample for job applications will live in:

`sql/analytics/uhf_sql_programming_sample.sql`

The final version will demonstrate complex joins, CTEs, window functions, data-quality logic, reusable transformations, and healthcare metrics against the actual project schema.

## Data privacy

This project will use synthetic or appropriately public/de-identified data only. No real patient PHI should be committed to this repository.

## Build in public

This project is being documented as part of **AI & Data With Ibrahim**.

**Learn • Build • Share • Inspire**
