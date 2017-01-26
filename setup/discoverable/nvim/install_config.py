import os
from os.path import join

from plumbum import FG

import settings
from utils.file_utils import install_dotfiles
from utils.messaging import echo
from utils.system import nvim_venv_pip


def install_neovim_dotfiles():
    echo('Installing neovim config...')

    install_dotfiles('nvim', '~/.config/nvim', 'neovim')

    # Make directory for persistent undo feature
    os.makedirs(join(settings.DOTFILES_REPO_DOTFILES_DIR, 'nvim/.undo'), exist_ok=True)

    # Install config for vim plugin manager
    install_dotfiles(
        'nvim/vim_plug/plug.vim', '~/.config/nvim/autoload/plug.vim', 'vim_plug',
    )

    echo('Neovim config installed!\n')


def install_plugin_python_dependencies():
    echo('Installing python dependencies for neovim plugins...')

    nvim_venv_pip['install', 'jedi'] & FG

    echo('Neovim plugin python dependencies installed!')


def install_config():
    install_neovim_dotfiles()
    install_plugin_python_dependencies()
