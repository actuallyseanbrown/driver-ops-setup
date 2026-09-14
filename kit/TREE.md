# driver-ops directory tree

What lands under `~/driver-ops` after `./install.sh` (or after you copy `kit/`).

```text
~/driver-ops/
├── README.md              ← DRIVER_OPS_SYSTEM (how we work)
├── AGENTS.md              ← instructions for Claude Code / AI agents
├── PROMOTE.md             ← NOTES → recipe promotion playbook
├── CHECKLIST.md           ← crunch-day + after-crunch
├── MERGE_RULES.md         ← extend history; newer wins on overlap
├── NOTES_TEMPLATE.md      ← blank NOTES for a new source shape
├── CLAUDE.md              ← project brain for Claude Code
├── core/                  ← Polars engine (empty until Build B)
├── templates/
│   └── client_template/   ← copy this for each new client
│       ├── README.md
│       ├── catalog/drivers.csv
│       ├── raw/
│       ├── recipes/_template/{NOTES.md,recipe.md}
│       ├── staging/
│       ├── warehouse/
│       ├── out/
│       └── runs/
└── clients/
    └── demo/              ← toy client (safe sample rows)
        ├── catalog/drivers.csv
        ├── raw/
        ├── recipes/example_source_shape/
        │   ├── NOTES.md
        │   ├── recipe.md
        │   └── recipe.py
        ├── staging/
        ├── warehouse/
        ├── out/
        └── runs/
```

## Folder meaning (memorize this)

| Folder | Rule |
|--------|------|
| `raw/` | Immutable landings. Never edit. |
| `catalog/` | Law. Enable/disable + lineage. |
| `recipes/<shape>/` | One folder per **source shape** (not per file). NOTES → recipe. |
| `staging/` | Crunch-day one-offs only (NOTES required). |
| `warehouse/` | Your merged monthly truth. |
| `out/` | Only thing that goes to the forecasting tool. |
| `runs/` | Run reports / rejects. |

## yazi jumps (after `client <slug>`)

| Keys | Goes to |
|------|--------|
| `g d` | `~/driver-ops` |
| `g r` | client `raw/` |
| `g c` | client `catalog/` |
| `g e` | client `recipes/` |
| `g s` | client `staging/` |
| `g o` | client `out/` |
| `g w` | client `warehouse/` |
