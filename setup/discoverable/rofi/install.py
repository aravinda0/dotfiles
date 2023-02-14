from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("rofi")


def install_config():
    install_dotfiles("rofi", "~/.config/rofi", "rofi")
