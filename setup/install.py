#!/usr/bin/env python3

from argparse import ArgumentParser, RawTextHelpFormatter
from textwrap import dedent

from utils.discovery import (
    get_available_setup_modules, get_tool_installer_module, get_config_installer_module,
    sorted_by_install_precedence
)


_available_tools = sorted(get_available_setup_modules())

_parser = ArgumentParser(
    description='One stop installer script to help install tools and/or their config for everything in the `setup/discoverable` folder.',  # noqa
    formatter_class=RawTextHelpFormatter
)
_parser.add_argument(
    'tools',
    nargs='*',
    help=dedent(
        '''\
        The specific tools who's respective installers should be run. If not specified, everything will be installed.
        The available tools are:
            {tools}
        '''.format(tools=', '.join(_available_tools))
    )
)
_group = _parser.add_mutually_exclusive_group()
_group.add_argument(
    '-t',
    '--tool-only',
    action='store_true',
    help='If specified, only the tools will be installed, without their config/dotfiles.'
)
_group.add_argument(
    '-c',
    '--config-only',
    action='store_true',
    help='If specified, only the config for the specified tools will be installed, without installing the actual tools themselves.'  # noqa
)


def install():
    """Takes an iterable of names of setup modules and invokes their tool/config installers."""
    args = _parser.parse_args()

    if args.tools:
        tools_to_process = sorted_by_install_precedence(args.tools)
    else:
        tools_to_process = get_available_setup_modules()

    for item in tools_to_process:
        if args.tool_only:
            _install_tool(item)
        elif args.config_only:
            _install_config(item)
        else:
            _install_tool(item)
            _install_config(item)


def _install_tool(tool):
    installer_module = get_tool_installer_module(tool)
    installer_module.install_tools()


def _install_config(tool):
    installer_module = get_config_installer_module(tool)
    installer_module.install_config()


if __name__ == "__main__":
    install()
