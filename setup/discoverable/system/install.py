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
    # manage disks and handle automounting
    "udisks2",
    "udiskie",
    #
    # easy privacy solution to encrypt dirs
    "encfs",
    #
    # fonts,
    "ttf-sourcecodepro-nerd",
    "noto-fonts-emoji",
    "noto-fonts-cjk",
    "noto-fonts-extra",
    #
    # html beautifier
    "tidy",
    #
    # screen temperature
    "redshift",
    #
    # url downloader (eg. for youtube, etc.)
    "yt-dlp",
]


def install_tools():
    system_update_package_databases()
    system_install("yay")
    system_install(packages)
