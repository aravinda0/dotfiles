import getpass
import subprocess

from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    """Distro package managers install nix in multi-user mode. We need to ensure the
    command-pass-through daemon is up and our user added to the `nix-users` group.
    """
    system_install("nix")

    subprocess.run(f"sudo gpasswd -a {getpass.getuser()} nix-users".split())

    subprocess.run("systemctl enable nix-daemon.service".split())
    subprocess.run("systemctl start nix-daemon.service".split())

    # Add and sync the main channel
    subprocess.run(
        "nix-channel --add https://nixos.org/channels/nixpkgs-unstable".split()
    )
    subprocess.run("nix-channel --update".split())


def install_config():
    install_dotfiles("nix", "~/.config/nix", "nix")
