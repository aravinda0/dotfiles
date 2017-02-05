from plumbum import FG

from utils.messaging import echo
from utils.system import pacman_install_f


packages_to_install = [
    'base-devel',

    # For building neovim
    'cmake', 'unzip',

    # For various tools/plugins that work with the clipboard
    'xclip',
]

def install_tools():
    echo('Installing system packages...')

    pacman_install_f[packages_to_install] & FG

    echo('System packages installed!')
