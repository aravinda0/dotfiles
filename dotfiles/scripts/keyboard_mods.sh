#! /bin/sh

# Use `setxkbmap` to make `caps-lock` behave like `ctrl`
# Use xcape to make it so we can tap `caps-lock` to make it behave like `esc` while
# holding it makes it work as `ctrl`

# NOTE: On xfce, there's an issue where the 'super' key is tied by default to the
# whisker-menu and it happens on keydown - so any super-mappings aren't triggered. We
# would have to remap the default whisker menu to `Alt-F1` and use xcape to trigger that
# when super is pressed by itself.
# `Super_L=Alt_L|F1`


setxkbmap -layout us -option ctrl:nocaps
xcape -e 'Caps_Lock=Escape;Control_L=Escape;Control_R=Escape;'
