from plumbum import FG
from plumbum.cmd import chsh

from utils.file_utils import install_dotfiles
from utils.messaging import echo
from utils.system.commands import pacman_install_f


def install_zsh_dotfiles():
    # Add shell startup files to standard locations
    install_dotfiles('zsh/zshenv', '~/.zshenv', 'zshenv')
    install_dotfiles('zsh/zshrc', '~/.zshrc', 'zshrc')
    install_dotfiles('zsh/zlogin', '~/.zlogin', 'zlogin')


def make_zsh_default_shell():
    chsh['-s', '/bin/zsh'] & FG


def install_zim():
    install_dotfiles('zsh/external/zimfw', '~/.zim', 'zim')
    install_dotfiles('zsh/config/zim/zimrc', '~/.zimrc', 'zimrc')


def install_zsh_plugins():
    pacman_install_f['fzf'] & FG


def install_config():
    echo('Installing zsh config...')

    make_zsh_default_shell()
    install_zsh_dotfiles()
    install_zim()
    install_zsh_plugins()

    echo('Zsh config installed!\n')
