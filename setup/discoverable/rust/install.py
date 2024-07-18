import subprocess

from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install("rustup")
    subprocess.run(["rustup", "default", "stable"])
    system_install("rust-analyzer")


def install_config():
    install_dotfiles("cargo/config.toml", "~/.cargo/config.toml", "cargo")
