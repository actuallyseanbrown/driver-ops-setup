# driver-ops-setup

Sanitized **personal** productivity pack for AI.Finance-style client data work on **Windows + Ubuntu WSL2**.

Includes:
- WezTerm / yazi / Neovim / VisiData / Claude Code configs that hand off cleanly
- Portable `driver-ops` kit templates (catalog, NOTES, merge rules, checklists)
- Claude Code tutor + `CLAUDE.md` / `AGENTS.md` / `PROMOTE.md`

**No client data.** Safe to clone on a work laptop.

## Quick start (WSL)

```bash
git clone https://github.com/actuallyseanbrown/driver-ops-setup.git ~/src/driver-ops-setup
cd ~/src/driver-ops-setup
./install.sh
```

Then:
1. Merge `wezterm/wezterm.lua` into Windows `%USERPROFILE%\.wezterm.lua`
2. Add `require('driverops')` to Neovim kickstart `init.lua`
3. Copy kit brain files into your working tree:
   ```bash
   mkdir -p ~/driver-ops
   cp claude/CLAUDE.md claude/AGENTS.md claude/PROMOTE.md ~/driver-ops/
   cp -R kit/templates ~/driver-ops/ 2>/dev/null || true
   cp driver-ops-overlay/* ~/driver-ops/ 2>/dev/null || true
   ```
4. Open Claude from project root: `cd ~/driver-ops && claude`

Keep client files under `~/driver-ops/clients/...` on the **Linux** filesystem — not `/mnt/c`.

## Layout

| Path | Purpose |
|---|---|
| `wezterm/` | Windows WezTerm config |
| `yazi/` | Openers + bookmarks |
| `nvim/` | `:Notes` / `:Catalog` helpers |
| `visidata/` | `.visidatarc` + plugins stub |
| `shell/` | `client` / `land` / `notes` |
| `claude/` | CLAUDE.md, AGENTS.md, PROMOTE.md, tutor |
| `kit/` | System docs + client_template |
| `driver-ops-overlay/` | NOTES template, checklist, merge rules |

## License

MIT — use and adapt freely. Don't commit client extracts to any remote.
