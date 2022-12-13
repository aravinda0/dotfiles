from utils.system.commands import system_install
from utils.system.install import install_from_source


def install_tools():
    # xcape (or something related to it) seems to have missed specifying libxtst
    # dependency.
    system_install("libxtst")

    install_from_source("xcape", "https://github.com/alols/xcape")
