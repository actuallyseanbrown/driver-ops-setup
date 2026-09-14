# AGENTS.md — how to help on this kit

You are assisting a novice/intermediate Python user who is **strong in VisiData** and works under tight client turnarounds on an AI.Finance forecasting team.

## Goals

- Preserve the operating system in README.md / CHECKLIST.md / MERGE_RULES.md.
- Prefer **config + small Polars recipes** over clever frameworks.
- Never require editing SharePoint files in place.
- Catalog (`catalog/drivers.csv`) is the control panel for enable/disable and lineage.

## When given VisiData NOTES.md

Turn the bullets into a replayable recipe:

1. Read `NOTES.md` and a sample of the raw file (or staged export).
2. Implement `recipe.py` (Polars) or a YAML map + shared helpers that:
   - renames columns into the forecasting drivers schema
   - applies filters / null handling described in NOTES
   - coerces dates to month grain using the driver's `grain_rule` from the catalog when possible
   - writes clean output suitable for warehouse merge
3. Keep the recipe **idempotent** and **documented** at the top (source shape, assumptions).
4. Do not invent meanings for `qualifier_2` or `denorm` — pass through or leave null if unknown.
5. Add/update catalog rows: set `status=mapped`, `source_recipe`, `source_files_glob`.

## When adding Polars / core code

- Lean deps: polars, pyyaml, python-dateutil.
- CLI shape eventually: `pipeline run --client <slug>`.
- Merge policy is fixed in MERGE_RULES.md — implement that, do not improvise.
- Emit a run report under `runs/` (row counts, extends, overwrites, rejects).
- Quarantine bad rows; do not fail the whole run for one bad key unless schema is broken.

## When the user is in crunch mode

1. Help them land raw + fill NOTES fast.
2. Allow staging export for one-off ship.
3. Immediately after, promote NOTES → recipe without being asked.

## Do not

- Build Airflow, dbt, or cloud infra for v1.
- Use file content hashes as change detection (SharePoint autosave).
- Quietly drop catalog-disabled drivers into `out/`.
- "Newest file wins" the entire series when the new file only extends history.
