#!/usr/bin/env python3

from os.path import join

from plumbum import local, FG
from plumbum.cmd import sh

import settings
from utils.file_utils import install_dotfiles
from utils.messaging import echo


fzf_dir = join(settings.DOTFILES_ROOT_DIR, 'dotfiles/fzf')
fzf_submodule_dir = join(fzf_dir, 'fzf')
fzf_install_path = '~/.fzf'


def install_fzf_and_config():
    """Installs fzf from the repo submodle.

    1. Run `install --bin` to only download fzf binary
    2. Make symlnk to `<dotfiles_root>dotfiles/fzf` from `~/.fzf`

    In this case, since the `fzf` directory gets symlinked, the config also gets
    installed, since the binaries and config are both present in our `fzf` directory.
    """
    echo('Installing fzf...')

    # Have fzf installer only download binaries, not write to shell startup files
    with local.cwd(fzf_submodule_dir):
        sh['install', '--bin'] & FG

    install_dotfiles(fzf_dir, fzf_install_path, 'fzf')

    echo('fzf installed!')


def install_tools():
    install_fzf_and_config()


if __name__ == '__main__':
    install_tools()
