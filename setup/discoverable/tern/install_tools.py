from plumbum import FG
from plumbum.cmd import sudo, npm

from utils.messaging import echo


def install_tools():
    echo('Installing tern globally...')

    sudo[npm['i', '-g', 'tern']] & FG

    echo('Tern globally installed!')
