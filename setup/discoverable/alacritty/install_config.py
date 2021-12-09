from plumbum import FG

from utils.messaging import echo
from utils.file_utils import install_dotfiles


def install_config():
    echo('Installing alacritty config...')

    install_dotfiles(
        'alacritty/alacritty.yml', '~/.config/alacritty/alacritty.yml', 'alacritty'
    )

    echo('Alacritty config installed!')
