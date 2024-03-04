from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("jupyterlab-desktop-bin")


def install_config():
    install_dotfiles(
        "jupyterlab/shortcuts.jupyterlab-settings",
        "~/.config/jupyterlab-desktop/lab/user-settings/@jupyterlab/shortcuts-extension/shortcuts.jupyterlab-settings",
        "jupyterlab-desktop",
    )
