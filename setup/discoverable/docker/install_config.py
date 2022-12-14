from utils.files import install_dotfiles


def install_config():
    install_dotfiles("docker/config.json", "~/.docker/config.json", "docker")
