#!/usr/bin/env python3

from plumbum import FG
from plumbum.cmd import pacman

from utils.messaging import echo


packages_to_install = [
    'base-devel', 'tmux', 'git',

    # For building neovim
    'cmake', 'unzip'
]

pacman_install = pacman['-S', '--noconfirm']


def install_system_packages():
    echo('Installing system packages...')

    pacman_install[packages_to_install] & FG

    echo('System packages installed!')


if __name__ == '__main__':
    install_system_packages()
