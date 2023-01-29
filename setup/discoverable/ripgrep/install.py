from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("ripgrep")


def install_config():
    install_dotfiles("ripgrep/ripgreprc", "~/.ripgreprc", "ripgreprc")
    install_dotfiles("ripgrep/rgignore", "~/.rgignore", "rgignore")
