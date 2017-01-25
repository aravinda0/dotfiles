import os
from os import path


_this_dir = path.dirname(path.abspath(__file__))

# During config installation etc., files are picked relative to this path
DOTFILES_REPO_ROOT_DIR = path.abspath(path.join(_this_dir, path.pardir))

# A symlink to the `dotfiles` dir is made at this location. This is later used in
# zsh config files to refer to various dependency paths.
DOTFILES_INSTALL_DIR = os.getenv('DOTFILES_INSTALL_DIR', '~/.dotfiles')

DOTFILES_BUILD_DIR = os.getenv(
    'DOTFILES_BUILD_DIR', path.join(DOTFILES_REPO_ROOT_DIR, 'build')
)

BACKUP_DIR_FOR_EXISTING_FILES = os.getenv(
    'BACKUP_DIR_FOR_EXISTING_FILES', path.expanduser('~/BACKED_UP_DOTFILES')
)

NVIM_VENVS_PATH = os.getenv('NVIM_VENVS_PATH', '~/.config/nvim/venvs')
NVIM_PY3_VENV_NAME = os.getenv('NVIM_PY3_VENV_NAME', 'neovim_py_3')
NVIM_PY3_VENV_PATH = path.join(path.expanduser(NVIM_VENVS_PATH), NVIM_PY3_VENV_NAME)
