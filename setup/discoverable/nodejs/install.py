import subprocess

from utils.system import system_install


def install_tools():
    system_install(["nodejs", "npm"])

    global_packages = [
        "pyright",
        "typescript-language-server",
        "@fsouza/prettierd",
        "emmet-ls",
        "svelte-language-server",
        "@tailwindcss/language-server",
    ]
    subprocess.run(["npm", "i", "-g", *global_packages])
