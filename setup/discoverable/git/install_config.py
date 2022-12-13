from utils.file_utils import install_dotfiles


def install_config():
    install_dotfiles("git/gitignore", "~/.gitignore", "gitignore")
    install_dotfiles("git/gitconfig", "~/.gitconfig", "gitconfig")
    print("Configure ~/.gitconfig.local for any private gitconfig directives.")
