#!/usr/bin/env python3

from plumbum import FG
from utils.system import pacman_install_f

from utils.messaging import echo


def install_tools():
    echo('Installing zsh...')

    pacman_install_f[['zsh']] & FG

    echo('zsh installed!')


if __name__ == '__main__':
    install_tools()
