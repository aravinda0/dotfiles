from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install(["zathura", "zathura-pdf-mupdf"])


def install_config():
    install_dotfiles("zathura", "~/.config/zathura", "zathura")
