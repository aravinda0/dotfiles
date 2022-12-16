from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("docker")


def install_config():
    install_dotfiles("docker/config.json", "~/.docker/config.json", "docker")
