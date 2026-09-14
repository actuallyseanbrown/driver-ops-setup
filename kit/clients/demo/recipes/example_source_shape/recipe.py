"""
Recipe: example_source_shape → plant_throughput_tons

Source shape (from NOTES.md, 2026-09-10):
  Month, Qty, PlantRegion, DriverName, ExportBatchId

Assumptions (documented — do not invent beyond NOTES):
  - DriverName blank → drop row (NOTES).
  - ExportBatchId is junk → ignored.
  - Month may be daily timestamps; coerce to month-end, then sum Qty (grain_rule=sum).
  - driver_unique_name is fixed: plant_throughput_tons.
  - Catalog defaults fill category/name/units/classification; region from PlantRegion.
  - qualifier, qualifier_2, denorm unknown → null (AGENTS.md: do not invent).
  - driver_source = landed filename; driver_capture_date = ingest date from landing name.

Idempotent: same input file(s) → same output rows (sorted by natural key).
"""

from __future__ import annotations

from pathlib import Path

import polars as pl

# Catalog-backed constants for this mapped driver (drivers.csv)
DRIVER_UNIQUE_NAME = "plant_throughput_tons"
DRIVER_NAME = "Plant throughput"
DRIVER_CATEGORY = "Operations"
DRIVER_CLASSIFICATION = "volume"
DRIVER_UNITS = "tons"
GRAIN_RULE = "sum"

CLIENT_ROOT = Path(__file__).resolve().parents[2]
RAW_GLOB = "raw/*throughput*"
OUT_SCHEMA = [
    "Date",
    "driver value",
    "driver category",
    "driver name",
    "driver unique name",
    "qualifier",
    "region",
    "driver units",
    "driver classification",
    "driver source",
    "driver capture date",
    "subregion",
    "qualifier_2",
    "denorm",
]


def _month_end(expr: pl.Expr) -> pl.Expr:
    """Coerce any date-like to calendar month-end."""
    d = expr.cast(pl.Date, strict=False)
    return d.dt.month_end()


def _capture_date_from_path(path: Path) -> str | None:
    # Landing convention: YYYY-MM-DD__descriptive.ext
    stem = path.name.split("__", 1)[0]
    if len(stem) >= 10 and stem[4] == "-" and stem[7] == "-":
        return stem[:10]
    return None


def transform(df: pl.DataFrame, *, source_name: str, capture_date: str | None) -> pl.DataFrame:
    # Rename per NOTES; keep DriverName only for the blank filter
    work = df.rename(
        {
            "Month": "Date",
            "Qty": "driver value",
            "PlantRegion": "region",
        }
    )

    if "DriverName" in work.columns:
        work = work.filter(
            pl.col("DriverName").is_not_null()
            & (pl.col("DriverName").cast(pl.Utf8).str.strip_chars() != "")
        )

    # Drop junk + any leftover source cols we do not map
    drop_cols = [c for c in ("ExportBatchId", "DriverName") if c in work.columns]
    if drop_cols:
        work = work.drop(drop_cols)

    work = work.with_columns(
        _month_end(pl.col("Date")).alias("Date"),
        pl.col("driver value").cast(pl.Float64, strict=False),
        pl.col("region").cast(pl.Utf8),
    ).filter(pl.col("Date").is_not_null() & pl.col("driver value").is_not_null())

    # Monthly grain: sum Qty (grain_rule=sum)
    work = (
        work.group_by(["Date", "region"])
        .agg(pl.col("driver value").sum())
        .with_columns(
            pl.lit(DRIVER_CATEGORY).alias("driver category"),
            pl.lit(DRIVER_NAME).alias("driver name"),
            pl.lit(DRIVER_UNIQUE_NAME).alias("driver unique name"),
            pl.lit(None, dtype=pl.Utf8).alias("qualifier"),
            pl.lit(DRIVER_UNITS).alias("driver units"),
            pl.lit(DRIVER_CLASSIFICATION).alias("driver classification"),
            pl.lit(source_name).alias("driver source"),
            pl.lit(capture_date).alias("driver capture date"),
            pl.lit(None, dtype=pl.Utf8).alias("subregion"),
            pl.lit(None, dtype=pl.Utf8).alias("qualifier_2"),
            pl.lit(None, dtype=pl.Utf8).alias("denorm"),
        )
        .select(OUT_SCHEMA)
        .sort(["Date", "region", "driver unique name"])
    )
    return work


def run(client_root: Path | None = None) -> pl.DataFrame:
    root = Path(client_root) if client_root else CLIENT_ROOT
    paths = sorted(root.glob(RAW_GLOB))
    if not paths:
        raise FileNotFoundError(f"No raw files matching {RAW_GLOB} under {root}")

    frames: list[pl.DataFrame] = []
    for path in paths:
        raw = pl.read_csv(path, try_parse_dates=True)
        frames.append(
            transform(
                raw,
                source_name=path.name,
                capture_date=_capture_date_from_path(path),
            )
        )

    out = pl.concat(frames, how="vertical_relaxed")
    # Same natural key across files: last file wins for overlapping months
    # (land order by sorted path; MERGE_RULES overlap = newer ingest wins)
    return (
        out.sort(["Date", "region", "driver unique name", "driver source"])
        .unique(subset=["Date", "region", "driver unique name"], keep="last")
        .sort(["Date", "region", "driver unique name"])
    )


if __name__ == "__main__":
    result = run()
    staging = CLIENT_ROOT / "staging"
    staging.mkdir(exist_ok=True)
    out_path = staging / "example_source_shape__drivers.parquet"
    result.write_parquet(out_path)
    print(f"rows={result.height} → {out_path}")
    print(result)
