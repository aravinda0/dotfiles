#!/usr/bin/env python3

import os

from settings import DOTFILES_ROOT_DIR
from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    echo('Installing neovim config...')

    install_dotfiles('dotfiles/nvim', '~/.config/nvim', 'neovim')

    # Make directory for persistent undo feature
    os.makedirs(os.path.join(DOTFILES_ROOT_DIR, 'dotfiles/nvim/.undo'), exist_ok=True)

    # Install config for vim plugin manager
    install_dotfiles(
        'dotfiles/nvim/vim_plug/plug.vim', '~/.config/nvim/autoload/plug.vim', 'vim_plug',
    )

    echo('Neovim config installed!\n')


if __name__ == '__main__':
    install_config()
