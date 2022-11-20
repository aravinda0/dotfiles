import venv

from plumbum import FG

import settings
from utils.messaging import echo
from utils.system.commands import nvim_venv_pip
from utils.system.install import install_from_source


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
    nvim_venv_pip['install', '-U', 'neovim'] & FG

    echo('Installed neovim python client in venv!')


def install_tools():
    make_params = {
        'CMAKE_BUILD_TYPE': 'RelWithDebInfo'
    }
    # install_from_source('nvim', 'https://github.com/neovim/neovim', make_params)
    setup_python_env_for_neovim()
