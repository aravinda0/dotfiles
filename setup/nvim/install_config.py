#!/usr/bin/env python3

import os

from settings import DOTFILES_ROOT_DIR
from utils.file_utils import install_dotfiles


def install_config():
    install_dotfiles('neovim', 'dotfiles/nvim', '~/.config/nvim')

    # Make directory for persistent undo feature
    os.makedirs(os.path.join(DOTFILES_ROOT_DIR, 'dotfiles/nvim/.undo'), exist_ok=True)

    # Install config for vim plugin manager
    install_dotfiles(
        'vim_plug', 'dotfiles/nvim/vim_plug/plug.vim', '~/.config/nvim/autoload/plug.vim'
    )


if __name__ == '__main__':
    install_config()
