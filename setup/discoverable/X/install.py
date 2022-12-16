from utils.files import install_dotfiles


def install_config():
    install_dotfiles("X/xprofile", "~/.xprofile", "xprofile")
