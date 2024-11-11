from utils.files import install_dotfiles
from utils.system import system_install


def install_tools():
    system_install(["lua", "lua51", "luajit", "luarocks", "lua-language-server"])


def install_config():
    # TODO: See if can get general config solution. Some platform dependency issues with
    # luarocks? Config wants to be written into `~/.luarocks/config-5.4.lua`. Don't like
    # the version specifier.

    # install_dotfiles("lua/luarocks", "~/.luarocks", "luarocks")
    pass
