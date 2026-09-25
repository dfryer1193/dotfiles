#!/usr/bin/env bash

# Configurations
TARGET_TITLE="SCRATCH"
SCRATCH_WORKSPACE="S" # Hidden background workspace for the scratchpad

CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# Find the window ID matching the title exactly
WINDOW_ID=$(aerospace list-windows --all --format "%{window-id}|%{window-title}" | grep "|${TARGET_TITLE}$" | cut -d'|' -f1 | head -n1)

# If the window doesn't exist, open iterm2 running tmux with that title
if [ -z "$WINDOW_ID" ]; then
    # Launches iTerm2, tells it to open a window named SCRATCH running tmux
    TMUX_BIN=$(command -v tmux)
    osascript -e 'tell application "iTerm2"' \
              -e "    set newWindow to (create window with profile \"SCRATCH\" command \"${TMUX_BIN} new-session\")" \
              -e '    tell current session of newWindow' \
              -e '        set name to "SCRATCH"' \
              -e '    end tell' \
    	      -e 'end tell'
    exit 0
fi

# Find which workspace the scratchpad is currently on
WINDOW_WORKSPACE=$(aerospace list-windows --all --format "%{window-id}|%{workspace}" | grep "^${WINDOW_ID}|" | cut -d'|' -f2)

# Toggle Logic
if [ "$WINDOW_WORKSPACE" == "$CURRENT_WORKSPACE" ]; then
    # If visible on current screen, hide it to the scratch workspace
    aerospace move-node-to-workspace --window-id "$WINDOW_ID" "$SCRATCH_WORKSPACE"
else
    # If hidden, bring it to the current workspace and focus it
    aerospace move-node-to-workspace --window-id "$WINDOW_ID" "$CURRENT_WORKSPACE"
    aerospace focus --window-id "$WINDOW_ID"
fi
