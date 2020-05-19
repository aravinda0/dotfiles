from utils.file_utils import install_dotfiles
from utils.messaging import echo


def install_config():
    install_poetry_config()
    install_flake8_config()


def install_poetry_config():
    echo('Installing poetry config...')
    install_dotfiles(
        'python/config.toml', '~/.config/pypoetry/config.toml', 'pypoetry_config'
    )
    echo('Poetry config installed!')


def install_flake8_config():
    echo('Installing global flake8 config...')
    install_dotfiles('python/flake8', '~/.flake8', 'global_flake8')
    echo('Global flake8 config installed!')
