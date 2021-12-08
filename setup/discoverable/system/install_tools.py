from plumbum import FG

from utils.messaging import echo
from utils.system.commands import pacman_install_f


packages_to_install = [
    'base-devel',

    # To enable stuff on system startup
    'systemd',

    # For building various things
    'make',

    # For building neovim
    'cmake', 'unzip',

    # pacman alternative
    'yay',

    # For various tools/plugins that work with the clipboard
    'xclip',

    # For general usage, and for installing some neovim plugins from npm
    'nodejs', 'npm',

    # ssh and related secrets management helpers
    'openssh', 'keychain',
]


def install_tools():
    echo('Installing system packages...')

    pacman_install_f[packages_to_install] & FG

    echo('System packages installed!')
