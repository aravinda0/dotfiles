#!/usr/bin/env python3

import os

from settings import DOTFILES_ROOT_DIR
from utils.file_utils import install_dotfiles


def install_all_dotfiles():
    install_dotfiles('dotfiles/nvim', '~/.config/nvim', 'neovim')
    install_dotfiles(
        'dotfiles/nvim/vim_plug/plug.vim', '~/.config/nvim/autoload/plug.vim', 'vim_plug'
    )


if __name__ == '__main__':
    install_all_dotfiles()
