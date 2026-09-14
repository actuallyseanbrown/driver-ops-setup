# Speed-run — use driver-ops in 10 minutes

## Once (WSL)

```bash
git clone https://github.com/actuallyseanbrown/driver-ops-setup.git ~/src/driver-ops-setup
cd ~/src/driver-ops-setup && ./install.sh
source ~/.bashrc
```

Then merge WezTerm on Windows + `require('driverops')` in nvim (install prints the checklist).

## Every session

```bash
client demo          # or: client <your_slug>
# WezTerm: Ctrl+a then d  → yazi at ~/driver-ops
```

## New client (30 seconds)

```bash
cp -R ~/driver-ops/templates/client_template ~/driver-ops/clients/acme
client acme
```

## New dump (the loop)

1. **Land** (never clean SharePoint in place)
   ```bash
   land ~/Downloads/plant_export.xlsx plant_throughput
   # → clients/<slug>/raw/YYYY-MM-DD__plant_throughput.xlsx
   ```

2. **Catalog** — `vcat` or yazi `g c` → Enter on `drivers.csv`  
   Add/edit rows. Unknowns: `status=needs_mapping`. Flip `enabled` on purpose.

3. **Explore** — yazi `g r`, Enter on the landed file → VisiData. Clean against the **raw copy**.

4. **NOTES** (5–10 bullets, same day)
   ```bash
   notes plant_throughput_xlsx    # opens recipes/<shape>/NOTES.md
   ```
   Shape = reusable pattern (e.g. `plant_throughput_xlsx`), **not** one NOTES per file.

5. **Crunch escape hatch** — export to `staging/` only if NOTES are filled. Promote within 24h.

6. **Promote** — from `~/driver-ops`:
   ```bash
   claude
   ```
   Ask: “Promote `recipes/<shape>/NOTES.md` to `recipe.py` per AGENTS.md + PROMOTE.md.”

7. **Ship** — build → `warehouse/` → filter enabled+mapped → `out/drivers.csv`. Only `out/` goes to the tool.

## Quarterly → monthly (when you hit it)

- Expand each quarter row to 3 month-end dates
- `$` values: **÷3**
- `%` values: **copy** (do not divide)
- Keep `driver_unique_name` on every row

## Muscle memory

| Command / keys | What |
|----------------|------|
| `client <slug>` | Set active client + cd there |
| `land <file> [label]` | Immutable copy into `raw/` |
| `notes <shape>` | Open/create NOTES for a shape |
| `vcat` | Catalog in VisiData |
| `Ctrl+a` `d` | yazi at driver-ops |
| `g d / r / c / e / s / o / w` | Jump folders in yazi |
| `v d` | Force open hover in VisiData |

## Do not

- Work under `/mnt/c` for data (copy into `$HOME`)
- Edit raw files
- Ship without NOTES
- Put client extracts in this GitHub repo
