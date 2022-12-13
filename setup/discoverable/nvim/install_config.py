from utils.file_utils import install_dotfiles


def install_config():
    install_dotfiles("nvim", "~/.config/nvim", "neovim")
