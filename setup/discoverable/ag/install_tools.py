from plumbum import FG
from utils.system.commands import pacman_install_f

from utils.messaging import echo


def install_tools():
    echo('Installing ag...')

    pacman_install_f[['the_silver_searcher']] & FG

    echo('Ag installed!')
