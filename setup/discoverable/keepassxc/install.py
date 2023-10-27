from utils.system import system_install


def install_tools():
    system_install("keepassxc")


def install_config():
    # NOTE: No config. Defaults suffice, and enabling the browser communication protocol
    # also leads to private key being stored in the config file.
    pass
