from utils.system import system_install, system_update_package_databases


packages = [
    "base-devel",
    "systemd",
    "make",
    "cmake",
    "unzip",
    #
    # For various tools/plugins that work with the clipboard
    "xclip",
    #
    # ssh and related secrets management helpers
    "openssh",
    "keychain",
    #
    # Nice no-nonsense file manager.
    "thunar",
    #
    # manage disks and handle automounting
    "udisks2",
    "udiskie",
    #
    # Screen brightness control
    "brightnessctl",
    #
    # easy privacy solution to encrypt dirs
    "gocryptfs",
    #
    # fonts,
    "ttf-sourcecodepro-nerd",
    "noto-fonts-emoji",
    "noto-fonts-cjk",
    "noto-fonts-extra",
    #
    # html beautifier
    # "tidy",
    #
    # screen temperature
    "redshift",
    #
    # url downloader (eg. for youtube, etc.)
    "yt-dlp",
    #
    # Simple MTP client - CLI, QT GUI. For android file transfers over USB.
    # Disable for now, since things like thunar seem to understand MTP.
    # "android-file-transfer",
]


def install_tools():
    system_update_package_databases()
    # system_install("yay")
    system_install(packages)
