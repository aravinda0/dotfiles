import subprocess

from utils.file_utils import install_dotfiles
from utils.system.commands import system_install


def install_zsh_dotfiles():
    install_dotfiles("zsh/zshenv", "~/.zshenv", "zshenv")
    install_dotfiles("zsh/zshrc", "~/.zshrc", "zshrc")
    install_dotfiles("zsh/zlogin", "~/.zlogin", "zlogin")


def make_zsh_default_shell():
    subprocess.run(["chsh", "-s", "/bin/zsh"])


def install_zim():
    install_dotfiles("zsh/external/zimfw", "~/.zim", "zim")
    install_dotfiles("zsh/config/zim/zimrc", "~/.zimrc", "zimrc")


def install_zsh_plugins():
    # TODO: move this out of here
    system_install("fzf")


def install_config():
    make_zsh_default_shell()
    install_zsh_dotfiles()
    install_zim()
    install_zsh_plugins()
