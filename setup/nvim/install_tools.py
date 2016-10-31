#!/usr/bin/env python3

import os
import sys
import venv

from plumbum import local, FG
from plumbum.cmd import sudo, mkdir, git, make

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
        sudo[make['install']] & FG

    echo('Neovim installed!')


def install_neovim_python_deps():
    """Sets up a dedicated python virtualenv for use by neovim - particularly for plugins
    such as deoplete-jedi.

    This prevents us having to install the neovim python lib into every virtualenv that
    needs it.
    Refs:
        https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
        https://github.com/zchee/deoplete-jedi/issues/21

    Note: Currently, it is assumed a Python 3 venv is created. The path to this venv
    is set to `g:python3_host_prog` in neovim settings.

    TODO: See if we can have a Py2 venv as well.
    """
    echo('Creating dedicated venv for neovim...')

    venv_path = make_neovim_venv()

    echo('Installing neovim python dependencies...')

    # Use the venv python's pip to install necessary packages inside that venv
    venv_pip = local[os.path.join(venv_path, 'bin/pip')]
    venv_pip['install', 'neovim'] & FG
    venv_pip['install', 'jedi'] & FG

    echo('Neovim python dependencies installed in venv!')


def make_neovim_venv():
    env_builder = venv.EnvBuilder(with_pip=True)
    venv_path = os.path.join(os.path.expanduser(settings.NVIM_VENVS_PATH), 'neovim_py_3')

    env_builder.create(venv_path)

    return venv_path


def install_tools():
    install_neovim_from_source()
    install_neovim_python_deps()


if __name__ == '__main__':
    install_tools()
