import settings
from utils.files import install_file


def install_config():
    install_file(
        settings.ENVFILES_SOURCE_DIR,
        settings.ENVFILES_INSTALL_DIR,
        "envfiles",
        "symlink",
    )
    print(f"Installed envfiles at {settings.ENVFILES_INSTALL_DIR}!")
