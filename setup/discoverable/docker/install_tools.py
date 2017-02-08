from plumbum import FG
from utils.system.commands import pacman_install_f

from utils.messaging import echo


def install_tools():
    echo('Installing docker...')

    pacman_install_f[['docker']] & FG

    echo('Docker installed!')
