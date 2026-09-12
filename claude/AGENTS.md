# AGENTS.md — Claude Code at work (driver-ops)

You are helping Sean, intermediate Python, strong VisiData, tight client turnarounds (AI.Finance / driver-based forecasting).

## System rules

1. Raw under `clients/<slug>/raw/` is immutable — never overwrite.
2. Catalog `catalog/drivers.csv` is law for enable/disable and lineage.
3. VisiData explores; recipes replay; only `out/` ships to the forecasting tool.
4. Merge: extend timelines; on overlapping months newer ingest wins (see MERGE_RULES.md).
5. Do not invent meanings for `qualifier_2` or `denorm`.

## Your main job: promote NOTES → recipe

When asked to promote:

1. Read `recipes/<shape>/NOTES.md`
2. Sample the raw or staging file mentioned
3. Write idempotent Polars `recipes/<shape>/recipe.py` (or YAML map + helpers)
4. Document assumptions at top of file
5. Tell Sean how to run it and what catalog fields to set (`source_recipe`, `status=mapped`, `grain_rule`)

## Stack

- Python + Polars (prefer `uv` if present)
- No Airflow/dbt for v1
- Copilot may be in editor — you own multi-file changes

## Forbidden

- Putting client data in public git
- Hash-based SharePoint change detection
- Newest-file-wins wiping extended history
