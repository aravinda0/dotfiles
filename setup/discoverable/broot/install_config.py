from utils.files import install_dotfiles


def install_config():
    install_dotfiles(
        "broot/config.hjson", "~/.config/broot/config.hjson", "broot_config"
    )
