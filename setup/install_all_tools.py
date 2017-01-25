#!/usr/bin/env python3

from system.install_tools import install_tools as install_system_tools
from docker.install_tools import install_tools as install_docker
from tern.install_tools import install_tools as install_tern
from nvim.install_tools import install_tools as install_nvim
from zsh.install_tools import install_tools as install_zsh


def install_tools():
    install_system_tools()
    install_docker()
    install_tern()
    install_nvim()
    install_zsh()


if __name__ == '__main__':
    install_tools()
