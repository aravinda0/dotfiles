from utils.system import system_install, system_install_from_source


def install_tools():
    # xcape (or something related to it) seems to have missed specifying libxtst
    # dependency.
    system_install("libxtst")

    system_install_from_source("xcape", "https://github.com/alols/xcape")
