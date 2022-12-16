#!/usr/bin/env python3

from argparse import ArgumentParser, RawTextHelpFormatter
from os.path import islink, realpath
from textwrap import dedent

import settings
from utils.discovery import (get_available_setup_modules, run_installer,
                             sort_by_install_precedence)
from utils.files import install_dotfiles

_available_tools = sorted(get_available_setup_modules())

_parser = ArgumentParser(
    description="One stop installer script to help install tools and/or their config for everything in the `setup/discoverable` folder.",  # noqa
    formatter_class=RawTextHelpFormatter,
)
_parser.add_argument(
    "tools",
    nargs="*",
    help=dedent(
        """\
        The specific tools who's respective installers should be run. If not specified, everything will be installed.
        The available tools are:
            {tools}
        """.format(
            tools=", ".join(_available_tools)
        )
    ),
)
_group = _parser.add_mutually_exclusive_group()
_group.add_argument(
    "-t",
    "--tool-only",
    action="store_true",
    help="If specified, only the tools will be installed, without their config/dotfiles.",
)
_group.add_argument(
    "-c",
    "--config-only",
    action="store_true",
    help="If specified, only the config for the specified tools will be installed, without installing the actual tools themselves.",  # noqa
)


def install():
    """Takes an iterable of names of setup modules and invokes their tool/config
    installers.
    """
    args = _parser.parse_args()

    ensure_dotfiles_available()

    if args.tools:
        tools_to_process = sort_by_install_precedence(args.tools)
    else:
        tools_to_process = get_available_setup_modules()

    for item in tools_to_process:
        if args.tool_only:
            run_installer(item, "install_tools")
        elif args.config_only:
            run_installer(item, "install_config")
        else:
            run_installer(item, "install_tools")
            run_installer(item, "install_config")


def ensure_dotfiles_available():
    """Checks if dotfiles are available at `settings.DOTFILES_INSTALL_DIR`, else creates
    a symlink at that location."""
    install_dir = settings.DOTFILES_INSTALL_DIR
    repo_dotfiles_dir = settings.DOTFILES_REPO_DOTFILES_DIR

    if islink(install_dir) and (realpath(install_dir) == repo_dotfiles_dir):
        # Everything is as expected.
        return

    # Install reference to dotfiles. (Blank string to `install_dotfiles()` will lead to
    # whole dotfiles dir being referenced)
    install_dotfiles("", install_dir, "dotfiles")
    print("Dotfiles are now linked from {install_dir}".format(install_dir=install_dir))


if __name__ == "__main__":
    install()
