import os
import subprocess
import shutil

import settings


def pip_install(packages: str | list[str]):
    if isinstance(packages, str):
        packages = [packages]

    subprocess.run(["pip", "install", *packages])


def nvim_venv_pip_install(packages: str | list[str], upgrade=True):
    if isinstance(packages, str):
        packages = [packages]

    pip = os.path.join(settings.NVIM_PY3_VENV_PATH, "bin/pip")
    pip_install = [pip, "install"]
    if upgrade:
        pip_install.append("-U")

    subprocess.run([*pip_install, *packages])


def system_update_package_databases():
    subprocess.run(["yay", "-Sy"])


def system_install(packages: str | list[str]):
    if isinstance(packages, str):
        packages = [packages]

    pkg_mgr = "yay" if shutil.which("yay") is not None else "pacman"
    subprocess.run([pkg_mgr, "-S", "--noconfirm", *packages])
