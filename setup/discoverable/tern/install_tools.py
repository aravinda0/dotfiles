#!/usr/bin/env python3

from plumbum import FG
from plumbum.cmd import sudo, npm


def install_tools():
    echo('Installing tern globally...')

    sudo[npm['i', '-g', 'tern']] & FG

    echo('Tern globally installed!')


if __name__ == '__main__':
    install_tools()
