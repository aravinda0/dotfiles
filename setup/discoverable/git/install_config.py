from plumbum import FG

from utils.messaging import echo
from utils.file_utils import install_dotfiles


def install_config():
    echo('Installing git config...')

    install_dotfiles('git/gitignore', '~/.gitignore', 'gitignore')
    install_dotfiles('git/gitconfig', '~/.gitconfig', 'gitconfig')

    echo('Git config installed!')
    echo('Edit ~/.gitconfig.local to add any private gitconfig directives.')
