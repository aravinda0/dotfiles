from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install(["qutebrowser-git", "python-adblock", "pdfjs"])


def install_config():
    install_dotfiles(
        "qutebrowser/config.py", "~/.config/qutebrowser/config.py", "qutebrowser config"
    )
    install_dotfiles(
        "qutebrowser/customize",
        "~/.config/qutebrowser/customize",
        "qutebrowser config customizations",
    )
    install_dotfiles(
        "qutebrowser/userscripts",
        "~/.config/qutebrowser/userscripts",
        "qutebrowser userscripts",
    )
