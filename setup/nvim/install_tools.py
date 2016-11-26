#!/usr/bin/env python3

import os
import sys
import venv

from plumbum import local, FG
from plumbum.cmd import sudo, mkdir, git, make

import settings
from utils.messaging import echo
from utils.system import nvim_venv_pip


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
        sudo[make['install']] & FG

    echo('Neovim installed!')


def setup_python_env_for_neovim():
    """Sets up a dedicated python virtualenv for use by neovim and installs the neovim
    python client inside it.

    This prevents us having to install the neovim python lib into every virtualenv that
    needs it. We also use the venv to install various plugin python dependencies
    (eg. jedi) instad of installing them globally.

    Refs:
        https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
        https://github.com/zchee/deoplete-jedi/issues/21

    Note: Currently, it is assumed a Python 3 venv is created. The path to this venv
    is set to `g:python3_host_prog` in neovim settings.

    TODO: See if we can have a Py2 venv as well.
    """
    echo('Creating dedicated venv for neovim...')

    env_builder = venv.EnvBuilder(with_pip=True)
    env_builder.create(settings.NVIM_PY3_VENV_PATH)

    echo('Installing neovim python client...')

    # Use the venv python's pip to install necessary packages inside that venv
    nvim_venv_pip['install', 'neovim'] & FG

    echo('Installed neovim python client in venv!')


def install_tools():
    install_neovim_from_source()
    setup_python_env_for_neovim()


if __name__ == '__main__':
    install_tools()
