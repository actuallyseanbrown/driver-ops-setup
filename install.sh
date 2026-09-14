#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "driver-ops-setup root: $ROOT"

mkdir -p ~/.config/yazi ~/.config/visidata/plugins ~/driver-ops
mkdir -p ~/.config/nvim/lua ~/.config/nvim/snippets

# --- rice ---
cp -f "$ROOT/yazi/yazi.toml" ~/.config/yazi/yazi.toml
cp -f "$ROOT/yazi/keymap.toml" ~/.config/yazi/keymap.toml
cp -f "$ROOT/visidata/visidatarc" ~/.config/visidata/visidatarc
cp -f "$ROOT/visidata/visidatarc" ~/.visidatarc
cp -f "$ROOT/nvim/lua/driverops.lua" ~/.config/nvim/lua/driverops.lua
cp -f "$ROOT/nvim/snippets/notes.snippet" ~/.config/nvim/snippets/notes.snippet
cp -f "$ROOT/nvim/snippets/driverrow.snippet" ~/.config/nvim/snippets/driverrow.snippet
cp -f "$ROOT/nvim/SNIPPETS.md" ~/.config/nvim/snippets/README-driverops.md

if ! grep -q 'driver-ops-setup/shell/driverops.sh\|work-rice/shell/driverops.sh\|shell/driverops.sh' ~/.bashrc 2>/dev/null; then
  echo "" >> ~/.bashrc
  echo "# driver-ops rice" >> ~/.bashrc
  echo "source \"$ROOT/shell/driverops.sh\"" >> ~/.bashrc
fi

# --- scaffold ~/driver-ops tree (never overwrite client data) ---
DO="$HOME/driver-ops"
mkdir -p "$DO/core" "$DO/templates" "$DO/clients"

# Brain docs
cp -f "$ROOT/kit/DRIVER_OPS_SYSTEM.md" "$DO/README.md"
cp -f "$ROOT/kit/AGENTS.md" "$DO/AGENTS.md"
cp -f "$ROOT/kit/CHECKLIST.md" "$DO/CHECKLIST.md"
cp -f "$ROOT/kit/MERGE_RULES.md" "$DO/MERGE_RULES.md"
cp -f "$ROOT/kit/TREE.md" "$DO/TREE.md"
cp -f "$ROOT/kit/SPEEDRUN.md" "$DO/SPEEDRUN.md"
cp -f "$ROOT/claude/PROMOTE.md" "$DO/PROMOTE.md"
cp -f "$ROOT/claude/CLAUDE.md" "$DO/CLAUDE.md" 2>/dev/null || true
cp -f "$ROOT/driver-ops-overlay/NOTES_TEMPLATE.md" "$DO/NOTES_TEMPLATE.md" 2>/dev/null || true
cp -f "$ROOT/kit/core/README.md" "$DO/core/README.md"

# Templates (refresh ok — no client data)
rm -rf "$DO/templates/client_template"
cp -R "$ROOT/kit/templates/client_template" "$DO/templates/client_template"

# Demo client: seed once; never clobber if already present
if [[ ! -d "$DO/clients/demo/catalog" ]]; then
  cp -R "$ROOT/kit/clients/demo" "$DO/clients/demo"
  echo "Seeded clients/demo"
else
  echo "Keeping existing clients/demo (not overwritten)"
fi

echo ""
echo "Installed."
echo "  Working tree: $DO"
echo "  See:          $DO/SPEEDRUN.md"
echo ""
echo "Still do MANUALLY:"
echo "  1. Merge wezterm/wezterm.lua into Windows %USERPROFILE%\\.wezterm.lua"
echo "  2. In nvim kickstart init.lua add:  require('driverops')"
echo "  3. source ~/.bashrc   (or open a new shell)"
echo "  4. client demo"
