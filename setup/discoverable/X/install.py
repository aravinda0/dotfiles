from utils.files import install_dotfiles


def install_config():
    install_dotfiles("X/xprofile", "~/.xprofile", "xprofile")
    install_dotfiles("X/desktop", "~/.local/share/applications", "desktop applications")
    install_dotfiles("X/mimeapps.list", "~/.config/mimeapps.list", "mimeapps.list")
