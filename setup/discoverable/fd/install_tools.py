from plumbum import FG
from utils.system.commands import pacman_install_f

from utils.messaging import echo


def install_tools():
    echo('Installing fd...')

    pacman_install_f[['fd']] & FG

    echo('fd installed!')
