#!/usr/bin/env python3

from plumbum import FG

from utils.messaging import echo
from utils.system import pacman_install_f


packages_to_install = [
    'base-devel', 'git',

    # For building neovim
    'cmake', 'unzip'
]

def install_tools():
    echo('Installing system packages...')

    pacman_install_f[packages_to_install] & FG

    echo('System packages installed!')


if __name__ == '__main__':
    install_tools()
