from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install(["git", "git-lfs"])


def install_config():
    install_dotfiles("git/gitignore", "~/.gitignore", "gitignore")
    install_dotfiles("git/gitconfig", "~/.gitconfig", "gitconfig")
    print("Configure ~/.gitconfig.local for any private gitconfig directives.")
