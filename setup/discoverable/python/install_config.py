from utils.files import install_dotfiles


def install_config():
    install_dotfiles(
        "python/config.toml", "~/.config/pypoetry/config.toml", "pypoetry_config"
    )
    install_dotfiles("ptpython/config.py", "~/.config/ptpython/config.py", "ptpython")
