import venv

import settings
from utils.files import install_dotfiles
from utils.system import (
    nvim_venv_pip_install,
    system_install,
    system_install_from_source,
)


def setup_python_venv_for_neovim():
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
    """
    print("Creating dedicated venv for neovim...")

    env_builder = venv.EnvBuilder(with_pip=True)
    env_builder.create(settings.NVIM_PY3_VENV_PATH)

    print("Installing neovim python client...")
    nvim_venv_pip_install("neovim")
    print("Installed neovim python client in venv!")

    print("Installing lua-language-server...")
    system_install("lua-language-server")
    print("Installed lua-language-server!")


def install_tools():
    make_params = {"CMAKE_BUILD_TYPE": "RelWithDebInfo"}
    system_install_from_source("nvim", "https://github.com/neovim/neovim", make_params)
    setup_python_venv_for_neovim()


def install_config():
    install_dotfiles("nvim", "~/.config/nvim", "neovim")
