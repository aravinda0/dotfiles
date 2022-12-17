import subprocess

from utils.system import system_install


def install_tools():
    system_install("rustup")
    subprocess.run(["rustup", "default", "stable"])
