from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    echo('Installing readling config...')

    install_dotfiles('readline/inputrc', '~/.inputrc', 'inputrc')

    echo('readline config intalled!')
