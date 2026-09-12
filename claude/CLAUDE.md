# CLAUDE.md — driver-ops (Claude Code reads THIS file)

@AGENTS.md

## Commands

- Prefer `uv run` if `uv` is available; else project venv / `python`
- Promote a shape: read `PROMOTE.md` and the shape's `NOTES.md`
- Never write into `clients/*/raw/`

## Sean's habits

- Strong in VisiData; intermediate Python — explain run steps plainly
- After recipe: list exact catalog CSV field updates
- Client data stays local; no secrets in git

## Verification

- Spot-check output columns against forecasting drivers schema in AGENTS.md / README
- Call out merge-extend vs overwrite assumptions
