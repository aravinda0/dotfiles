from os.path import join
import shutil

from settings import DOTFILES_REPO_ROOT_DIR, BACKUP_DIR_FOR_EXISTING_FILES
from utils.messaging import echo


def resolve_backup_path(path, key):
    """
    """
    relative_path = path[1:] if path.startswith('/') else path
    return join(BACKUP_DIR_FOR_EXISTING_FILES, key, relative_path)


def backup_if_exists(path, key):
    """
    """
    if os.path.exists(path):
        backup_path = resolve_backup_path(path, key)
        backup_path_parent = os.path.abspath(join(backup_path, os.path.pardir))

        # Make necessary dirs in backup folder corresponding to original path
        os.makedirs(backup_path_parent, exist_ok=True)

        shutil.move(path, backup_path)

        return backup_path

    return None


def install_file(src, dest, key, install_method='copy'):
    """Backs up the target `dest` if it's present and then copies/moves/symlinks `src` to
    `dest`.

    Args:
        src: The source file
        dest: The destination target
        key: A name under which the `dest` file will be backed up if it was present.
        install_method: One of {copy, move, symlink}. Specifies how `src` is installed at
            `dest`.
    """
    abs_src = os.path.expanduser(src)
    abs_dest = os.path.expanduser(dest)

    backed_up_path = backup_if_exists(abs_dest, key)
    if backed_up_path is not None:
        echo(
            "The target {dest} seems to exist already. Moved it to backup path at "
            "'{backup_path}'".format(dest=abs_dest, backup_path=backed_up_path)
        )

    os.makedirs(os.path.abspath(join(abs_dest, os.path.pardir)), exist_ok=True)

    if install_method == 'copy':
        # Try copying as a directory. If it fails, try copying as a file.
        try:
            shutil.copytree(abs_src, abs_dest)
        except shutil.Error:
            shutil.copy2(abs_src, abs_dest)
    elif install_method == 'move':
        shutil.move(abs_src, abs_dest)
    elif install_method == 'symlink':
        os.symlink(abs_src, abs_dest)
    else:
        raise ValueError(
            'Invalid `creation_method` specified. Must be one of \{copy, move, symlink\}'
        )


def install_dotfiles(src, dest, key):
    """Wrapper around `install_file` that accepts src paths that are relative to the
    dotfiles repo root and symlinks to dest.
    """
    install_file(join(DOTFILES_REPO_ROOT_DIR, src), dest, key, 'symlink')
