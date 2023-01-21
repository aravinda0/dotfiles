from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("dunst")


def install_config():
    install_dotfiles("dunst", "~/.config/dunst", "dunst")
