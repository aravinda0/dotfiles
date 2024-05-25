import getpass
import subprocess

from utils.system import system_install


def install_tools():
    system_install("syncthing")
    subprocess.run(["systemctl", "enable", f"syncthing@{getpass.getuser()}"])
    subprocess.run(["systemctl", "start", f"syncthing@{getpass.getuser()}"])
