#!/usr/bin/env bash
# Ctrl+h/j/k/l in Herdr (bound in ~/.config/herdr/config.toml), one key set for panes and Neovim splits:
# if the focused pane runs Neovim/Vim (or fzf), pass the key through so Neovim moves between its own
# splits (and calls `herdr pane focus` itself at its edge, see ~/.config/nvim/lua/config/mux_nav.lua);
# otherwise move to the neighbouring Herdr pane.
# Usage: navigate.sh left|down|up|right
set -u

direction=${1:-}
herdr=${HERDR_BIN_PATH:-}
# HERDR_BIN_PATH may resolve into /opt/homebrew/Cellar/herdr/<ver>/bin/herdr, which `brew upgrade` cleans up.
[[ -x $herdr ]] || herdr=/opt/homebrew/bin/herdr
[[ -x $herdr ]] || herdr=herdr
pane=${HERDR_ACTIVE_PANE_ID:-}
[[ -n $pane ]] || exit 0

case $direction in
  left) key=ctrl+h ;;
  down) key=ctrl+j ;;
  up) key=ctrl+k ;;
  right) key=ctrl+l ;;
  *) exit 1 ;;
esac

info=$("$herdr" pane process-info --pane "$pane" 2>/dev/null)
if [[ $info =~ \"name\":\"(nvim|vim|vi|view|nvimdiff|vimdiff|fzf)\" ]]; then
  exec "$herdr" pane send-keys "$pane" "$key"
fi
exec "$herdr" pane focus --direction "$direction" --pane "$pane"
