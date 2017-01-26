from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    echo('Installing tern config...')

    install_dotfiles('dotfiles/tern/tern-config', '~/.tern-config', 'tern')

    echo('Tern config installed!')
