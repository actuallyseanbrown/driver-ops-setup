# driver-ops-setup

Sanitized **personal** productivity pack for AI.Finance-style client data work on **Windows + Ubuntu WSL2**.

- WezTerm / yazi / Neovim / VisiData / Claude Code configs
- Portable `~/driver-ops` **directory tree** (catalog, NOTES, merge rules, demo client)
- Speed-run: [`kit/SPEEDRUN.md`](kit/SPEEDRUN.md) · Tree map: [`kit/TREE.md`](kit/TREE.md)

**No client data.** Safe to clone on a work laptop.

## Quick start (WSL)

```bash
git clone https://github.com/actuallyseanbrown/driver-ops-setup.git ~/src/driver-ops-setup
cd ~/src/driver-ops-setup
./install.sh
source ~/.bashrc
client demo
```

`install.sh` scaffolds `~/driver-ops` with the full tree (templates + demo). It will **not** overwrite an existing `clients/demo` if you already land files there.

Then manually:
1. Merge `wezterm/wezterm.lua` into Windows `%USERPROFILE%\.wezterm.lua`
2. Add `require('driverops')` to Neovim kickstart `init.lua`
3. Open Claude from project root: `cd ~/driver-ops && claude`

Keep client files under `~/driver-ops/clients/...` on the **Linux** filesystem — not `/mnt/c`.

## The tree (what you work in)

```text
~/driver-ops/
├── README.md / AGENTS.md / CHECKLIST.md / MERGE_RULES.md / SPEEDRUN.md
├── core/                    ← Polars engine later
├── templates/client_template/
└── clients/<slug>/
    ├── catalog/drivers.csv  ← law
    ├── raw/                 ← immutable landings
    ├── recipes/<shape>/     ← NOTES.md → recipe.py
    ├── staging/             ← crunch escape hatch
    ├── warehouse/           ← merged monthly truth
    ├── out/                 ← forecasting tool only
    └── runs/
```

## Daily loop (30-second version)

```bash
client acme
land ~/Downloads/export.xlsx plant_throughput
vcat                              # edit catalog
# yazi: g r → Enter → clean in VisiData
notes plant_throughput_xlsx       # 5–10 bullets
claude                            # “promote NOTES → recipe”
# ship only out/
```

New client: `cp -R ~/driver-ops/templates/client_template ~/driver-ops/clients/<slug>`

## Layout of this repo

| Path | Purpose |
|---|---|
| `kit/` | System docs + `templates/` + `clients/demo` |
| `shell/` | `client` / `land` / `notes` |
| `yazi/` `wezterm/` `nvim/` `visidata/` | Rice |
| `claude/` | CLAUDE.md, AGENTS.md, PROMOTE.md, tutor |
| `driver-ops-overlay/` | NOTES template extras |

## License

MIT — use and adapt freely. Don't commit client extracts to any remote.
