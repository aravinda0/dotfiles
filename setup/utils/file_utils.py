import os
import shutil

from settings import DOTFILES_ROOT_DIR, BACKUP_DIR_FOR_EXISTING_FILES
from utils.messaging import echo


def resolve_backup_path(path, key):
    """
    """
    relative_path = path[1:] if path.startswith('/') else path
    return os.path.join(BACKUP_DIR_FOR_EXISTING_FILES, key, relative_path)


def backup_if_exists(path, key):
    """
    """
    if os.path.exists(path):
        backup_path = resolve_backup_path(path, key)
        backup_path_parent = os.path.abspath(os.path.join(backup_path, os.path.pardir))

        # Make necessary dirs in backup folder corresponding to original path
        os.makedirs(backup_path_parent, exist_ok=True)

        shutil.move(path, backup_path)

        return backup_path

    return None


def install_dotfiles(key, relative_src, dest):
    echo('Installing dotfiles for {key}...'.format(key=key))

    dotfiles_src = os.path.join(DOTFILES_ROOT_DIR, relative_src)
    dotfiles_dest = os.path.expanduser(dest)

    backed_up_path = backup_if_exists(dotfiles_dest, key)
    if backed_up_path is not None:
        echo(
            "Found existing configuration for {key} at '{orig_path}'. Backed it up at "
            "'{backup_path}'".format(
                key=key, orig_path=dotfiles_dest, backup_path=backed_up_path
            )
        )

    os.makedirs(
        os.path.abspath(os.path.join(dotfiles_dest, os.path.pardir)), exist_ok=True
    )
    os.symlink(dotfiles_src, dotfiles_dest)

    echo('Dotfiles for {key} installed!\n\n'.format(key=key))
