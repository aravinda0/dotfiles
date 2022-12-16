import subprocess

from utils.files import install_dotfiles
from utils.system import pip_install

binary_packages = [
    "poetry",
    "httpie",
    "ipython",
    "ptpython",
    "black",
    "isort",
]


def install_tools():
    print("First installing pipx...")

    pip_install("pipx")

    print("pipx installed!")

    print("Installing python binary packages via pipx...")

    subprocess.run(["pipx", "install", *binary_packages])

    print("Python binary packages installed")


def install_config():
    install_dotfiles(
        "python/config.toml", "~/.config/pypoetry/config.toml", "pypoetry_config"
    )
    install_dotfiles("ptpython/config.py", "~/.config/ptpython/config.py", "ptpython")
