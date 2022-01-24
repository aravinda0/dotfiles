from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    echo("Installing broot config...")

    install_dotfiles(
        "broot/config.hjson", "~/.config/broot/config.hjson", "broot_config"
    )

    echo("broot config installed!")
