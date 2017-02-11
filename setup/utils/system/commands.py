from os.path import join

from plumbum import local
from plumbum.cmd import pacman, sudo, pip

import settings


pacman_install_f = sudo[pacman['-S', '--noconfirm']]

pip_install_global = sudo[pip['install']]

nvim_venv_pip = local[join(settings.NVIM_PY3_VENV_PATH, 'bin/pip')]
