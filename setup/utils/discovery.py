import importlib
import os
from os.path import join

from settings import DOTFILES_REPO_ROOT_DIR


IGNORED_DISCOVERABLE_DIRS = [
    '__pycache__',
]
ENFORCED_SETUP_MODULE_ORDER = [
    'system',
    # Everything else can be in any order
]


def sorted_by_install_precedence(setup_modules):
    """
    Takes an iterable of setup module names and returns the ideal order in which they
    may be processed.
    Modules mentioned in `ENFORCED_SETUP_MODULE_ORDER` are processed first. The rest
    are processed in user specified order.
    """
    sorted_modules = list(m for m in setup_modules if m in ENFORCED_SETUP_MODULE_ORDER)
    sorted_modules.extend(
        m for m in setup_modules if m not in ENFORCED_SETUP_MODULE_ORDER
    )
    return sorted_modules


def get_available_setup_modules():
    """Returns a list of available 'discoverable' setup modules."""
    _, dirs, _ = next(os.walk(join(DOTFILES_REPO_ROOT_DIR, 'setup/discoverable')))
    setup_modules = [x for x in dirs if x not in IGNORED_DISCOVERABLE_DIRS]
    return sorted_by_install_precedence(setup_modules)


def get_tool_installer_module(name):
    return importlib.import_module(
        'discoverable.{name}.install_tools'.format(name=name)
    )


def get_config_installer_module(name):
    return importlib.import_module(
        'discoverable.{name}.install_config'.format(name=name)
    )