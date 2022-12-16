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
    # For general usage, and for installing some neovim plugins from npm
    "nodejs",
    "npm",
    #
    # manage disks and handle automounting
    "udisks2",
    "udiskie",
]


def install_tools():
    system_update_package_databases()
    system_install("yay")
    system_install(packages)
