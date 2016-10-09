#!/usr/bin/env python3

from plumbum import FG
from plumbum.cmd import pacman, chsh

from utils.messaging import echo


packages_to_install = [
    'base-devel', 'zsh', 'tmux', 'git',

    # For building neovim
    'cmake', 'unzip'
]

pacman_install = pacman['-S', '--noconfirm']


def make_zsh_default_shell():
    chsh['-s', '/bin/zsh'] & FG


def install_system_packages():
    echo('Installing system packages...')
    pacman_install[packages_to_install] & FG
    echo('System packages installed!')

    make_zsh_default_shell()


if __name__ == '__main__':
    install_system_packages()
