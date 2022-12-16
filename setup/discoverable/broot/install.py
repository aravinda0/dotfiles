from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("broot")


def install_config():
    install_dotfiles(
        "broot/config.hjson", "~/.config/broot/config.hjson", "broot_config"
    )
