from os.path import join

from plumbum import local
from plumbum.cmd import pacman, sudo

import settings


pacman_install_f = sudo[pacman['-S', '--noconfirm']]

nvim_venv_pip = local[join(settings.NVIM_PY3_VENV_PATH, 'bin/pip')]
