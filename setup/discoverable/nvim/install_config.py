import os
from os.path import join

from plumbum import FG

import settings
from utils.file_utils import install_dotfiles, make_file_from_template
from utils.messaging import echo
from utils.system.commands import nvim_venv_pip


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

    py_packages = [
        'flake8',
        'python-language-server',
    ]

    nvim_venv_pip['install', py_packages] & FG

    echo('Neovim plugin python dependencies installed!')


def install_plugin_dotfiles():
    # coc-vim's coc-settings.json.
    substitutions = {
        'NVIM_PY3_VENV_PATH': settings.NVIM_PY3_VENV_PATH,
    }
    make_file_from_template(
        'nvim/config/plugins/coc-settings.template.json',
        join(
            settings.DOTFILES_REPO_DOTFILES_DIR,
            'nvim/config/plugins/coc-settings.json'
        ),
        substitutions
    )
    install_dotfiles(
        'nvim/config/plugins/coc-settings.json',
        '~/.config/nvim/coc-settings.json',
        'coc-settings.json',
        install_method='move'
    )


def install_config():
    install_neovim_dotfiles()
    install_plugin_python_dependencies()
    install_plugin_dotfiles()
