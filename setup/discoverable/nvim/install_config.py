from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_neovim_dotfiles():
    echo("Installing neovim config...")

    install_dotfiles("nvim", "~/.config/nvim", "neovim")

    echo("Neovim config installed!\n")


def install_config():
    install_neovim_dotfiles()
