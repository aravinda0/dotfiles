from utils.files import install_dotfiles


def install_config():
    install_dotfiles("sqlite/sqliterc", "~/.sqliterc", "sqlite")
