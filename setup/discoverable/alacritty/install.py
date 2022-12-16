from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("alacritty")


def install_config():
    install_dotfiles(
        "alacritty/alacritty.yml", "~/.config/alacritty/alacritty.yml", "alacritty"
    )
