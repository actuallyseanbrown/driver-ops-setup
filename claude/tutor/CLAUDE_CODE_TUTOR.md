# Claude Code tutor — for Sean (driver-ops)

## Should you use the `.md` files?

**Yes.** Without them Claude is amnesiac every session.

| File | Who reads it |
|---|---|
| `CLAUDE.md` (repo root) | Claude Code (required). Keep short. Include `@AGENTS.md`. |
| `AGENTS.md` | Shared agents; Claude via `@` import |
| `PROMOTE.md` | Your promote checklist prompt |
| `NOTES.md` | You write; Claude consumes |
| `~/.claude/CLAUDE.md` | Global defaults |

Claude Code does **not** load `AGENTS.md` alone — put `@AGENTS.md` in `CLAUDE.md`.

## Power habits

1. Always `cd ~/driver-ops && claude`
2. `/init` once, then trim to pack CLAUDE.md
3. `/clear` between unrelated tasks; `/compact` when soggy; `/memory` to prune
4. Promote: point at NOTES + raw path; don't vibe-prompt
5. Copilot = autocomplete; Claude Code = multi-file lead
6. Always verify in VisiData yourself

## Money workflow

```text
Read PROMOTE.md and recipes/<shape>/NOTES.md.
Sample the raw file named there (read-only).
Write recipes/<shape>/recipe.py in Polars.
Do not touch raw/.
Tell me catalog fields to set and how to run.
```

If Claude drifts, fix the markdown — don't argue harder in chat.
