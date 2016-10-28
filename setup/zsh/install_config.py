#!/usr/bin/env python3

from plumbum import FG
from plumbum.cmd import chsh

from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_zsh_dotfiles():
    install_dotfiles('dotfiles/zsh/zshenv', '~/.zshenv', 'zshenv')
    install_dotfiles('dotfiles/zsh/zshrc', '~/.zshrc', 'zshrc')


def make_zsh_default_shell():
    chsh['-s', '/bin/zsh'] & FG


def install_config():
    echo('Installing zsh config...')

    make_zsh_default_shell()
    install_zsh_dotfiles()

    echo('Zsh config installed!\n')


if __name__ == '__main__':
    install_config()
