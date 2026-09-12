# driver-ops

Portable operating system for turning messy client extracts into forecasting-ready **drivers** (and later **accounts**).

You do not rise to the level of your goals. You fall to the level of your systems. This repo *is* the system.

## Principles

1. **Raw is sacred** — never clean the client's SharePoint file in place. Land an immutable copy under `raw/`.
2. **Catalog is law** — if a driver is not in the catalog, it does not ship. Toggles and lineage live here.
3. **Explore ≠ produce** — VisiData discovers; recipes replay; only `out/` goes to the forecasting tool.
4. **Merge is a policy** — extend timelines; on overlapping months, newer ingest wins.
5. **Portable** — copy `templates/client_template` for each client. Core stays the same.
6. **Write it down** — if it is not in the catalog, recipe notes, or a run report, it did not happen.

## Day-one flow

1. Land → `raw/YYYY-MM-DD__descriptive.csv`
2. Register catalog rows (`needs_mapping` OK)
3. Explore in VisiData
4. Capture 5–10 NOTES bullets
5. Promote NOTES → recipe within 24h
6. Build → warehouse → `out/drivers.csv`
7. Ship only `out/`

## Forecasting contracts

**drivers:** Date, driver value, driver category, driver name, driver unique name, qualifier, region, driver units, driver classification, driver source, driver capture date, subregion, qualifier_2, denorm (monthly grain)

**accounts (phase 2):** Period key, plant key, BU key, product group, product key, account key, value, version key, profit center key, cost center key, tags
