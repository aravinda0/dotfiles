#!/usr/bin/env python3

from nvim.install_config import install_config as install_nvim_config
from zsh.install_config import install_config as install_zsh_config


def install_config():
    install_nvim_config()
    install_zsh_config()


if __name__ == '__main__':
    install_config()
