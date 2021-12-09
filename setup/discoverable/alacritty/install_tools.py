from plumbum import FG
from utils.system.commands import pacman_install_f

from utils.messaging import echo


def install_tools():
    echo('Installing alacritty..')

    pacman_install_f[['alacritty']] & FG

    echo('Alacritty installed!')
