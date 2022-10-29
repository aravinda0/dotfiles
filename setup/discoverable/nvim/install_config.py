import os
from os.path import join

from plumbum import FG

import settings
from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_neovim_dotfiles():
    echo("Installing neovim config...")

    install_dotfiles("nvim", "~/.config/nvim", "neovim")

    # Make directory for persistent undo feature
    os.makedirs(join(settings.DOTFILES_REPO_DOTFILES_DIR, "nvim/.undo"), exist_ok=True)

    # Install config for vim plugin manager
    install_dotfiles(
        "nvim/vim_plug/plug.vim",
        "~/.config/nvim/autoload/plug.vim",
        "vim_plug",
    )

    echo("Neovim config installed!\n")


def install_config():
    install_neovim_dotfiles()
