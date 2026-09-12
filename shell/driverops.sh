# Sean driver-ops shell rice — sourced from ~/.bashrc
export DRIVER_OPS_HOME="${DRIVER_OPS_HOME:-$HOME/driver-ops}"

driverops() { cd "$DRIVER_OPS_HOME" || return; }

client() {
  local slug="${1:-}"
  if [[ -z "$slug" ]]; then
    echo "DRIVER_OPS_CLIENT=${DRIVER_OPS_CLIENT:-unset}"
    return 0
  fi
  local path="$DRIVER_OPS_HOME/clients/$slug"
  if [[ ! -d "$path" ]]; then
    echo "No client at $path — copy from templates/client_template first"
    return 1
  fi
  export DRIVER_OPS_CLIENT="$path"
  cd "$DRIVER_OPS_CLIENT" || return
  echo "Active client: $DRIVER_OPS_CLIENT"
}

land() {
  local src="${1:-}" label="${2:-extract}"
  if [[ -z "$src" || ! -f "$src" ]]; then
    echo "usage: land <file> [label]"; return 1
  fi
  if [[ -z "${DRIVER_OPS_CLIENT:-}" ]]; then
    echo "Run: client <slug>  first"; return 1
  fi
  mkdir -p "$DRIVER_OPS_CLIENT/raw"
  local day ext dest
  day="$(date +%F)"; ext="${src##*.}"
  dest="$DRIVER_OPS_CLIENT/raw/${day}__${label}.${ext}"
  cp -n "$src" "$dest" || { echo "Refusing overwrite: $dest"; return 1; }
  echo "Landed: $dest"
  echo "Open:  vd \"$dest\""
}

notes() {
  local shape="${1:-}"
  if [[ -z "$shape" || -z "${DRIVER_OPS_CLIENT:-}" ]]; then
    echo "usage: client <slug>; notes <source_shape>"; return 1
  fi
  local dir="$DRIVER_OPS_CLIENT/recipes/$shape"
  mkdir -p "$dir"
  local f="$dir/NOTES.md"
  if [[ ! -f "$f" ]]; then
    cp "$DRIVER_OPS_HOME/NOTES_TEMPLATE.md" "$f" 2>/dev/null || printf '# Recipe notes — %s\n\n## What I did\n- \n' "$shape" > "$f"
  fi
  nvim "$f"
}

alias vdraw='yazi "${DRIVER_OPS_CLIENT:-$DRIVER_OPS_HOME/clients/demo}/raw"'
alias vcat='vd "${DRIVER_OPS_CLIENT:-$DRIVER_OPS_HOME/clients/demo}/catalog/drivers.csv"'
alias dout='yazi "${DRIVER_OPS_CLIENT:-$DRIVER_OPS_HOME/clients/demo}/out"'

_driverops_cwd_warn() {
  case "$PWD" in
    /mnt/c/*|/mnt/d/*) echo "[driver-ops] You're on /mnt/* — copy data into \$HOME for VisiData/Polars speed." ;;
  esac
}
PROMPT_COMMAND="_driverops_cwd_warn${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
