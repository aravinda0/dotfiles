from plumbum import FG

from utils.messaging import echo
from utils.file_utils import install_dotfiles


def install_config():
    echo('Installing tmux config...')

    install_dotfiles('tmux/tmux.conf', '~/.tmux.conf', 'tmux.conf')

    echo('Tmux config installed!\n')
