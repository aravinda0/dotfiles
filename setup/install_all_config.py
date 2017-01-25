#!/usr/bin/env python3

from nvim.install_config import install_config as install_nvim_config
from docker.install_config import install_config as install_docker_config
from zsh.install_config import install_config as install_zsh_config
from tern.install_config import install_config as install_tern_config
from nvim.install_config import install_config as install_nvim_config


def install_config():
    install_nvim_config()
    install_docker_config()
    install_zsh_config()
    install_tern_config()
    install_nvim_config()


if __name__ == '__main__':
    install_config()
