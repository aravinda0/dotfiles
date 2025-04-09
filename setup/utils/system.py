import errno
import os
import shutil
import subprocess

import settings


pkg_mgr = "paru" if shutil.which("paru") is not None else "pacman"


def pip_install(packages: str | list[str]):
    if isinstance(packages, str):
        packages = [packages]

    subprocess.run(["python", "-m", "ensurepip"])
    subprocess.run(["python", "-m", "pip", "install", *packages])


def nvim_venv_pip_install(packages: str | list[str], upgrade=True):
    if isinstance(packages, str):
        packages = [packages]

    pip = os.path.join(settings.NVIM_PY3_VENV_PATH, "bin/pip")
    pip_install = [pip, "install"]
    if upgrade:
        pip_install.append("-U")

    subprocess.run([*pip_install, *packages])


def system_update_package_databases():
    subprocess.run([pkg_mgr, "-Sy"])


def system_install(packages: str | list[str]):
    if isinstance(packages, str):
        packages = [packages]

    subprocess.run([pkg_mgr, "-S", "--noconfirm", *packages])


def system_install_from_source(program_name, git_repo, make_options=None):
    make_options = make_options or {}

    build_dir = settings.DOTFILES_BUILD_DIR
    program_build_dir = os.path.join(settings.DOTFILES_BUILD_DIR, program_name)

    try:
        os.makedirs(build_dir)
    except OSError as e:
        if e.errno == errno.EEXIST and os.path.isdir(build_dir):
            pass

    if os.path.lexists(program_build_dir):
        print(f"Deleting existing build files for {program_name}...")
        shutil.rmtree(program_build_dir)

    print(f"Cloning {program_name} repo...")
    subprocess.run(
        ["git", "clone", "--depth", "1", git_repo, program_name], cwd=build_dir
    )

    print(f"Building and installing {program_name}...")

    make_params = [f"{option}={value}" for option, value in make_options.items()]
    subprocess.run(["make", *make_params], cwd=program_build_dir)
    subprocess.run(["sudo", "make", "install"], cwd=program_build_dir)

    print(f"{program_name} installed!")
