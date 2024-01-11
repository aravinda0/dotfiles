from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("feh")


def install_config():
    install_dotfiles("feh", "~/.config/feh", "feh")
