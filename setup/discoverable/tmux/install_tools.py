from plumbum import FG

from utils.messaging import echo
from utils.system.commands import pacman_install_f


def install_tools():
    echo('Installing tmux...')

    pacman_install_f[['tmux']] & FG

    echo('Tmux installed!')
