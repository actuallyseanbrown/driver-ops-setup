# Operating checklist

## New extract (crunch day)

- [ ] Copy file off SharePoint into `clients/<name>/raw/YYYY-MM-DD__descriptive.ext`
- [ ] Do **not** treat SharePoint filename or file hash as truth
- [ ] Open `catalog/drivers.csv` in VisiData; add/update rows for requested drivers
- [ ] Set new unknowns to `status=needs_mapping`, `enabled=true` or `false` deliberately
- [ ] Clean in VisiData against the **raw copy**
- [ ] Write 5–10 bullets in `recipes/<source_shape>/NOTES.md`
- [ ] If deadline forces it: export to `staging/` and ship **only with NOTES filled**
- [ ] Calendar a same-day/next-morning promote: NOTES → recipe

## After crunch (within 24h)

- [ ] AI agent (or you) turns NOTES into `recipe.py` / map
- [ ] Point catalog `source_recipe` + `source_files_glob`
- [ ] Set `status=mapped` for drivers this recipe covers
- [ ] Run build into `warehouse/` then `out/`
- [ ] Skim `runs/` report: extends, overwrites, rejects
- [ ] Delete or ignore the one-off staging export as source of truth

## Toggle a driver on/off

- [ ] Flip `enabled` in the catalog
- [ ] Re-run build → new `out/drivers.csv`
- [ ] No rescrape required if warehouse already has it

## New client

- [ ] `cp -R templates/client_template clients/<slug>`
- [ ] Fill catalog from engagement scope (first principles; OK to start sparse)
- [ ] Land first raw dumps
- [ ] One source shape at a time through the flow above

## Rescrape this engagement from scratch

- [ ] New/empty warehouse (archive old experiments if needed)
- [ ] Fresh raw copies of current sources
- [ ] Rebuild catalog rows you actually want
- [ ] Recipe per source shape → merge → out
- [ ] Declare: warehouse + catalog are truth
