from utils.file_utils import install_dotfiles


def install_config():
    install_dotfiles("tmux/tmux.conf", "~/.tmux.conf", "tmux.conf")
