#!/usr/bin/env python3

from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    echo('Installing docker config...')

    install_dotfiles(
        'dotfiles/docker/config.json', '~/.docker/config.json', 'docker_config'
    )

    echo('Docker config installed!')


if __name__ == "__main__":
    install_config()
