from plumbum import FG

from utils.system.commands import pacman_install_f
from utils.system.install import install_from_source


def install_tools():
    # xcape (or something related to it) seems to have missed specifying libxtst
    # dependency.
    pacman_install_f['libxtst'] & FG

    install_from_source('xcape', 'https://github.com/alols/xcape')
