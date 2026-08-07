import os
from pathlib import Path

from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.engine import Engine


def load_env_file(env_path: str | None = None) -> Path:
    if env_path is None:
        env_path = Path(__file__).resolve().parents[2] / ".env"
    else:
        env_path = Path(env_path)

    if env_path.exists():
        load_dotenv(dotenv_path=env_path, override=False)
    return env_path


def get_database_url() -> str:
    load_env_file()

    host = os.getenv("POSTGRES_HOST") or os.getenv("DB_HOST") or "localhost"
    port = os.getenv("POSTGRES_PORT") or os.getenv("DB_PORT") or "5432"
    database = os.getenv("POSTGRES_DB") or os.getenv("DB_NAME")
    username = os.getenv("POSTGRES_USER") or os.getenv("DB_USER")
    password = os.getenv("POSTGRES_PASSWORD") or os.getenv("DB_PASSWORD")

    missing = []
    for name, value in {
        "POSTGRES_DB / DB_NAME": database,
        "POSTGRES_USER / DB_USER": username,
        "POSTGRES_PASSWORD / DB_PASSWORD": password,
    }.items():
        if not value:
            missing.append(name)

    if missing:
        raise ValueError(
            "Missing PostgreSQL environment variables. Provide POSTGRES_DB/DB_NAME, "
            "POSTGRES_USER/DB_USER, and POSTGRES_PASSWORD/DB_PASSWORD in .env."
        )

    return (
        f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}"
    )


def create_db_engine() -> Engine:
    return create_engine(get_database_url(), pool_pre_ping=True, future=True)
