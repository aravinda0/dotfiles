from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    install_poetry_config()


def install_poetry_config():
    echo('Installing poetry config...')
    install_dotfiles(
        'python/config.toml', '~/.config/pypoetry/config.toml', 'pypoetry_config'
    )
    echo('Poetry config installed!')
