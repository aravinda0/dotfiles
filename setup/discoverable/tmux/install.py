from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("tmux")


def install_config():
    install_dotfiles("tmux/tmux.conf", "~/.tmux.conf", "tmux.conf")
