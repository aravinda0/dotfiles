from utils.files import install_dotfiles


def install_config():
    install_dotfiles("psql/psqlrc", "~/.psqlrc", "psql")
