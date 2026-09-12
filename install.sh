#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
echo "work-rice root: $ROOT"

mkdir -p ~/.config/yazi ~/.config/visidata/plugins ~/driver-ops
mkdir -p ~/.config/nvim/lua ~/.config/nvim/snippets

cp -f "$ROOT/yazi/yazi.toml" ~/.config/yazi/yazi.toml
cp -f "$ROOT/yazi/keymap.toml" ~/.config/yazi/keymap.toml

cp -f "$ROOT/visidata/visidatarc" ~/.config/visidata/visidatarc
cp -f "$ROOT/visidata/visidatarc" ~/.visidatarc

cp -f "$ROOT/nvim/lua/driverops.lua" ~/.config/nvim/lua/driverops.lua

if ! grep -q 'driver-ops-setup/shell/driverops.sh\|driverops.sh' ~/.bashrc 2>/dev/null; then
  echo "" >> ~/.bashrc
  echo "# driver-ops rice" >> ~/.bashrc
  echo "source \"$ROOT/shell/driverops.sh\"" >> ~/.bashrc
fi

mkdir -p ~/driver-ops
cp -f "$ROOT/claude/CLAUDE.md" ~/driver-ops/CLAUDE.md
cp -f "$ROOT/claude/AGENTS.md" ~/driver-ops/AGENTS.md
cp -f "$ROOT/claude/PROMOTE.md" ~/driver-ops/PROMOTE.md
cp -f "$ROOT/driver-ops-overlay/"* ~/driver-ops/ 2>/dev/null || true

echo ""
echo "WSL pieces installed. Still do MANUALLY:"
echo "  1. Copy wezterm/wezterm.lua into Windows %USERPROFILE%/.wezterm.lua (merge if you already rice)"
echo "  2. In nvim kickstart init.lua add:  require('driverops')"
echo "  3. Restart WezTerm + source ~/.bashrc"
echo "  4. Open Claude Code in ~/driver-ops"
