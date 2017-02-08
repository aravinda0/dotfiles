from os.path import join

from plumbum import local, FG
from plumbum.cmd import sudo, git, make, mkdir

import settings
from utils.messaging import echo


def install_from_source(program_name, git_repo):
    build_dir = settings.DOTFILES_BUILD_DIR
    mkdir['-p'](build_dir)

    # TODO: Check if program already present on system (use 'which' or shutils.which)
    # TODO: Check for existing directory

    echo('Cloning {program_name} repo...'.format(program_name=program_name))

    with local.cwd(build_dir):
        git['clone', git_repo, program_name] & FG

    echo('Building and installing {program_name}...'.format(program_name=program_name))

    with local.cwd(join(build_dir, program_name)):
        make & FG
        sudo[make['install']] & FG

    echo('{program_name} installed!'.format(program_name=program_name))
