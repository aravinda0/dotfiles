from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install([
        "python-pykeepass",
        "python-pynput",
        "keepmenu-git",
    ])


def install_config():
    install_dotfiles("keepmenu", "~/.config/keepmenu", "keepmenu")
