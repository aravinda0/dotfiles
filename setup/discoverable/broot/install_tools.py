from plumbum import FG
from utils.system.commands import pacman_install_f

from utils.messaging import echo


def install_tools():
    echo("Installing broot...")

    pacman_install_f[["broot"]] & FG

    echo("broot installed!")
