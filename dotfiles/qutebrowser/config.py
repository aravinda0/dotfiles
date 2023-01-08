"""
- Docs:
    - qute://help/configuring.html 
    - qute://help/settings.html
        - qute://help/settings.html#bindings.default
    - qute://help/commands.html
    - qute://help/userscripts.html

- Generate file with default config:
    - `:config-write-py --defaults --force`
"""

# These are globals that qutebrowser makes available when processing this file. These
# self-assignments are just to silence checkers and linters.
c = c  # pyright:ignore[reportUndefinedVariable]
config = config  # pyright:ignore[reportUndefinedVariable]


# We need to explicitly specify whether or not to load autoconfig when config.py is
# present.
config.load_autoconfig(False)

# Load color scheme
config.source("customize/gruvbox.py")


c.fonts.default_family = ["Source Code Pro"]
c.fonts.default_size = "12pt"
# c.qt.highdpi = False


c.scrolling.smooth = True


# Use both python-adblock and hosts blocking
c.content.blocking.method = "both"


# Somewhat more generic user agent to help combat fingerprinting
c.content.headers.user_agent = (
    "Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0"
)


c.auto_save.session = True


c.hints.chars = "asdghjklwernmiop"


c.editor.command = [
    "alacritty",
    "-e",
    "zsh",
    "-c",
    "-i",
    "nvim",
    "{file}",
    # "'nvim {file} -c normal {line}G{column0}l'",
]


c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "r": "https://duckduckgo.com/?q={}+site%3Areddit.com",
    "g": "https://github.com/search?q={}",
    "gc": "https://github.com/search?q={}&type=code",
    "s": "https://sourcegraph.com/search?q=context:global+{}&patternType=standard&sm=1",
}


# --------------------------------------------------------------------------------
# Keymaps: normal mode
# --------------------------------------------------------------------------------

config.bind("K", "tab-next")
config.bind("J", "tab-prev")

config.bind("<ctrl-y>", "run-with-count 3 scroll up")
config.bind("<ctrl-e>", "run-with-count 3 scroll down")

config.bind("<ctrl-p>", "set-cmd-text -s :open")

config.bind("<ctrl-shift-p>", "spawn qutebrowser --target private-window")

# Hard refresh
config.bind("<ctrl-shift-r>", "reload -f")


# --------------------------------------------------------------------------------
# Keymaps: command mode
# --------------------------------------------------------------------------------

config.bind("<ctrl-j>", "completion-item-focus next", mode="command")
config.bind("<ctrl-k>", "completion-item-focus prev", mode="command")


# --------------------------------------------------------------------------------
# Keymaps: hint mode
# --------------------------------------------------------------------------------

config.bind("f", "mode-leave", mode="hint")
