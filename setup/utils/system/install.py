import errno
import os
import subprocess
import shutil

import settings


def install_from_source(program_name, git_repo, make_options=None):
    make_options = make_options or {}

    build_dir = settings.DOTFILES_BUILD_DIR

    try:
        os.makedirs(build_dir)
    except OSError as e:
        if e.errno == errno.EEXIST and os.path.isdir(build_dir):
            pass

    if os.path.lexists(os.path.join(build_dir, program_name)):
        print(f"Deleting existing build files for {program_name}...")
        shutil.rmtree(program_name)

    print(f"Cloning {program_name} repo...")
    subprocess.run(["git", "clone", git_repo, program_name], cwd=build_dir)

    print(f"Building and installing {program_name}...")

    make_params = [f"{option}={value}" for option, value in make_options.items()]
    subprocess.run(["make", *make_params], cwd=build_dir)
    subprocess.run(["make", "install"], cwd=build_dir)

    print(f"{program_name} installed!")
