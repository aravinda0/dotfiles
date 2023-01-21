from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("mpv")


def install_config():
    install_dotfiles("mpv", "~/.config/mpv", "mpv")
