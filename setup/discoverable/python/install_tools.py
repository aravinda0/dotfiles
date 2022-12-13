import subprocess

from utils.system.commands import pip_install


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
