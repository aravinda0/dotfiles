#!/usr/bin/env python3

from utils.messaging import echo


def install_config():
    echo(
        'fzf config installation is a no-op, since the config gets installed during '
        'installation of fzf. See notes in `setup/fzf/install_tools.py`'
    )
    pass

if __name__ == '__main__':
    install_config()
