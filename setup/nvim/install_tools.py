#!/usr/bin/env python3

import os

from plumbum import local, FG
from plumbum.cmd import mkdir, git, make, pip

import settings
from utils.messaging import echo


build_dir = settings.DOTFILES_BUILD_DIR
neovim_repo = 'https://github.com/neovim/neovim'

def install_neovim_from_source():
    mkdir['-p'](build_dir)

    echo('Cloning neovim repo...')

    # TODO: Check if neovim already present on system (use 'which' or shutils.which)
    # TODO: Check for existing directory

    with local.cwd(build_dir):
        git['clone', neovim_repo] & FG

    echo('Building and installing neovim...')

    with local.cwd(os.path.join(build_dir, 'neovim')):
        make & FG
        make['install'] & FG

    echo('Neovim installed!')

def install_neovim_python_client():
    echo('Installing neovim python client...')

    pip['install', 'neovim'] & FG

    echo('Neovim python client installed!')


def install_tools():
    install_neovim_from_source()
    install_neovim_python_client()


if __name__ == '__main__':
    install_tools()
