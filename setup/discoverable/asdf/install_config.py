from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    echo('Installing asdf config...')
    install_dotfiles('asdf/tool-versions', '~/.tool-versions', 'asdf')
    echo('asdf config installed!')
