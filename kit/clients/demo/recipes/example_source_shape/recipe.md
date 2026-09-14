# Recipe — example_source_shape

Status: `mapped`

**Driver:** `plant_throughput_tons`  
**Code:** `recipe.py` (Polars)  
**Inputs:** catalog `source_files_glob` = `raw/*throughput*`  
**Grain:** `sum` daily Qty → month-end Date

## What it does

1. Renames `Month` → Date, `Qty` → driver value, `PlantRegion` → region
2. Drops rows where `DriverName` is blank
3. Ignores `ExportBatchId`
4. Coerces Date to month-end; sums value by (Date, region)
5. Fills catalog constants; leaves qualifier / qualifier_2 / denorm / subregion null

## Assumptions

See module docstring in `recipe.py`. Sample raw shipped for smoke-test; replace with real landings.

## Run

```bash
.venv/bin/python clients/demo/recipes/example_source_shape/recipe.py
```

Writes `clients/demo/staging/example_source_shape__drivers.parquet`.
