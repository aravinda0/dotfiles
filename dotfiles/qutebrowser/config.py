"""
- Docs:
    - qute://help/configuring.html 
    - qute://help/settings.html
        - qute://help/settings.html#bindings.default
    - qute://help/commands.html
    - qute://help/userscripts.html

- Generate file with default config:
    - `:config-write-py --defaults --force`

- `:bind`
    - to view all current bindings
- `:set`
    - to view all current options
- `:process`
    - to view userscript run info
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


# Load user stylesheets
c.content.user_stylesheets = "./customize/cosmetic_adblock.css"


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


c.completion.open_categories = ["quickmarks", "bookmarks", "history", "filesystem"]


c.auto_save.session = True


c.hints.chars = "asdghjklwernmiop"


c.editor.command = [
    "alacritty",
    "--class",
    "util_mode_editor",
    "-e",
    "nvim",
    "{file}",
    "-c",
    "normal {line}G{column0}l",
]


c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "r": "https://duckduckgo.com/?q=site%3Areddit.com+{}",
    "i": "https://duckduckgo.com/?q={}&ia=images&iax=images",
    "hn": "https://duckduckgo.com/?q=site%3Anews.ycombinator.com+{}",
    "p": "https://phind.com/search?q={}",
    "w": "https://en.wikipedia.org/w/index.php?search={}",
    "g": "https://github.com/search?q={}",
    "gc": "https://github.com/search?q={}&type=code",
    "s": "https://sourcegraph.com/search?q=context:global+{}&patternType=standard&sm=1",
    "dic": "https://en.wiktionary.org/wiki/{}",
    "y": "https://www.youtube.com/results?search_query={}",
    "aur": "https://aur.archlinux.org/packages/?O=0&K={}",
    "aw": "https://wiki.archlinux.org/index.php?title=Special%3ASearch&search={}",
    "t": "https://www.magnetdl.com/search/?m=1&q={}",
}


# --------------------------------------------------------------------------------
# Keymaps: normal mode
# --------------------------------------------------------------------------------

# Stop deleting tabs inadvertantly
config.unbind("d")

config.bind("<space>rc", "config-source")

config.bind("<ctrl-p>", "set-cmd-text -s :open")
config.bind("<ctrl-shift-p>", "spawn qutebrowser --target private-window")

config.bind("<ctrl-t>", "open -t")
config.bind("<ctrl-o>", "set-cmd-text -s :quickmark-load")

config.bind("<ctrl-y>", "run-with-count 3 scroll up")
config.bind("<ctrl-e>", "run-with-count 3 scroll down")

config.bind("K", "tab-next")
config.bind("J", "tab-prev")
config.bind("<alt-r>", "tab-next")
config.bind("<alt-e>", "tab-prev")
config.bind("<ctrl-tab>", "tab-next")
config.bind("<ctrl-shift-tab>", "tab-prev")

config.bind("yt", "tab-clone")

config.bind("yf", "hint links yank")
config.bind(";i", "hint inputs")
config.bind(";Ii", "hint images")
config.bind(";II", "hint images tab")

config.bind("m", "mode-enter set_mark")

config.bind("M", "quickmark-save")

# Hard refresh
config.bind("<ctrl-shift-r>", "reload -f")

# Help screens
config.bind("<space>hm", "open -t ;; bind")
config.bind("<space>ho", "open -t ;; set")
config.bind("<space>hh", "open -t ;; help")
config.bind("<space>hc", "open -t qute://help/commands.html")

# Edit stuff
config.bind("ge", "edit-url")
config.bind("gc", "edit-command")


# --------------------------------------------------------------------------------
# Keymaps: command mode
# --------------------------------------------------------------------------------

config.bind("<ctrl-e>", "completion-item-focus next;; rl-end-of-line", mode="command")
config.bind("<ctrl-y>", "completion-item-focus prev", mode="command")
config.bind("<ctrl-j>", "completion-item-focus next", mode="command")
config.bind("<ctrl-k>", "completion-item-focus prev", mode="command")
config.bind("<ctrl-w>", "rl-backward-kill-word", mode="command")
config.bind("<ctrl-alt-w>", "rl-filename-rubout", mode="command")

config.bind("<ctrl-return>", "spawn --userscript complete_tld.py", mode="command")


# --------------------------------------------------------------------------------
# Keymaps: hint mode
# --------------------------------------------------------------------------------

config.bind("f", "mode-leave", mode="hint")
