# Recipe notes — example_source_shape

**Raw file(s):** `raw/2026-09-10__plant_throughput_export.csv`
**Ingested:** 2026-09-10

## What I did (bullets — be specific)

- Renamed `Month` → Date, `Qty` → driver value, `PlantRegion` → region
- Dropped rows where driver name blank
- Coerced Date to month-end
- Summed daily qty to monthly tons (`grain_rule=sum`)
- Set driver_unique_name=`plant_throughput_tons`
- Ignored junk column `ExportBatchId`

## Drivers this source should feed

- `plant_throughput_tons` — operations volume

## Crunch ship?

- [ ] Exported to `staging/` for deadline
- [x] Must promote to recipe within 24h
