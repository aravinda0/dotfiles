from utils.file_utils import install_dotfiles


def install_config():
    install_dotfiles("readline/inputrc", "~/.inputrc", "inputrc")
