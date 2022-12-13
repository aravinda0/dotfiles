from utils.file_utils import install_dotfiles


def install_config():
    install_dotfiles(
        "alacritty/alacritty.yml", "~/.config/alacritty/alacritty.yml", "alacritty"
    )
