#! /bin/sh

# We use xcape to handle some keypress behaviours:

# 1. Make 'caps lock' behave like 'escape' when tapped, or like 'ctrl' when used
# with another key

# 2. On xfce, there's an issue where the 'super' key is tied by default to the whisker-menu
# and it happens on keydown - so any super-mappings aren't triggered.
# We remap the default whisker menu to `Alt-F1` and use xcape to trigger that when super
# is pressed by itself.

xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape;Super_L=Alt_L|F1'
