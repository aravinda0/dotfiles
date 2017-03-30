from os.path import join, lexists

from plumbum import local, FG
from plumbum.cmd import sudo, git, make, mkdir, rm

import settings
from utils.messaging import echo


def install_from_source(program_name, git_repo, make_options=None):
    make_options = make_options or {}

    build_dir = settings.DOTFILES_BUILD_DIR
    mkdir['-p', build_dir] & FG

    with local.cwd(build_dir):
        if lexists(join(build_dir, program_name)):
            echo('Deleting existing build files for {program_name}...')
            rm['-rf', program_name] & FG

        echo('Cloning {program_name} repo...'.format(program_name=program_name))
        git['clone', git_repo, program_name] & FG

    echo('Building and installing {program_name}...'.format(program_name=program_name))

    make_params = [
        '{option}={value}'.format(option=option, value=value) for
        option, value in make_options.items()
    ]

    with local.cwd(join(build_dir, program_name)):
        make[make_params] & FG
        sudo[make['install']] & FG

    echo('{program_name} installed!'.format(program_name=program_name))
