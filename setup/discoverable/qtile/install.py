from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("qtile")


def install_config():
    install_dotfiles("qtile", "~/.config/qtile", "qtile")
