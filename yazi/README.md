# yazi

Copy `yazi.toml` + `keymap.toml` to `~/.config/yazi/`.

Uses **`[mgr]`** (not deprecated `[manager]`).

## Bookmarks (`g` chords)

Requires `client <slug>` for client paths (`DRIVER_OPS_CLIENT`).

| Keys | Goes to |
|------|--------|
| `g d` | `~/driver-ops` (overrides stock Downloads) |
| `g l` | `~/Downloads` (stock Downloads remapped here) |
| `g c` | client `catalog/` (overrides stock config) |
| `g C` | `~/.config` (stock config remapped here) |
| `g r` | client `raw/` |
| `g e` | client `recipes/` |
| `g s` | client `staging/` |
| `g o` | client `out/` |
| `g w` | client `warehouse/` |
| `v d` | force open hover in VisiData |

Data files (csv/xlsx/…) open in VisiData; md/py open in nvim.

After pulling, restart yazi fully so which-key labels refresh.
