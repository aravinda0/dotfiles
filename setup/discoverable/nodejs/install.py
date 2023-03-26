import subprocess

from utils.system import system_install


def install_tools():
    system_install(["nodejs"])

    global_packages = [
        "pyright",
        "typescript-language-server",
        "emmet-ls",
        "@tailwindcss/language-server",
    ]
    subprocess.run(["npm", "i", "-g", *global_packages])
