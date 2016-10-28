#!/usr/bin/env python3

from system.install_tools import install_tools as install_system_tools
from docker.install_tools import install_tools as install_docker
from nvim.install_tools import install_tools as install_nvim
from zsh.install_tools import install_tools as install_zsh
from fzf.install_tools import install_tools as install_fzf


def install_tools():
    install_system_tools()
    install_docker()
    install_nvim()
    install_zsh()
    install_fzf()


if __name__ == '__main__':
    install_tools()
