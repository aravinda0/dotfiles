#!/usr/bin/env python3

import os

from plumbum.cmd import chsh

from settings import DOTFILES_ROOT_DIR
from utils.file_utils import install_dotfiles


def install_zsh_dotfiles():
    install_dotfiles('zshenv', 'dotfiles/zsh/zshenv', '~/.zshenv')
    install_dotfiles('zshrc', 'dotfiles/zsh/zshrc', '~/.zshrc')


def make_zsh_default_shell():
    chsh['-s', '/bin/zsh'] & FG


def install_config():
    make_zsh_default_shell()
    install_zsh_dotfiles()


if __name__ == '__main__':
    install_config
