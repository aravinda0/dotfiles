import subprocess

from utils.files import install_dotfiles
from utils.system import system_install

binary_packages = [
    "httpie",
    "ipython",
    "ptpython",
    "pdm",
    "ruff",
    "ruff-lsp",
    "cookiecutter",
]


def install_tools():
    print("First installing pipx...")
    system_install("python-pipx")
    print("pipx installed!")

    print("Installing python binary packages via pipx...")
    for package in binary_packages:
        subprocess.run(["pipx", "install", package])
    print("Python binary packages installed")


def install_config():
    install_dotfiles("ptpython/config.py", "~/.config/ptpython/config.py", "ptpython")
    install_dotfiles("ruff/pyproject.toml", "~/.config/ruff/pyproject.toml", "ruff")
