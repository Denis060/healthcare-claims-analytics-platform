# ETL

Python ingestion code will be added after the Synthea files are selected.

Principles:
- configuration through environment variables
- idempotent loads where practical
- explicit logging
- validation before database load
- no PHI or secrets committed
