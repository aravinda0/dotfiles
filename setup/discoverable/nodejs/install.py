import subprocess

from utils.system import system_install


def install_tools():
    system_install(["nodejs", "npm"])

    global_packages = [
        "typescript",
        "typescript-language-server",
        "svelte-language-server",
        "@tailwindcss/language-server",
        "basedpyright",
        "@fsouza/prettierd",
        "emmet-ls",
    ]
    subprocess.run(["npm", "i", "-g", *global_packages])
