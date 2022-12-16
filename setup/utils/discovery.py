import importlib
import os
import types
from importlib import \
    util as importlib_util  # Has to be imported as `from x import y`
from os.path import join

from settings import DOTFILES_REPO_ROOT_DIR

IGNORED_DISCOVERABLE_DIRS = [
    "__pycache__",
]
ENFORCED_SETUP_MODULE_ORDER = [
    "system",
    "git",
    # Everything else can be in any order
]


def sort_by_install_precedence(setup_modules):
    """
    Takes an iterable of setup module names and returns the ideal order in which they
    may be processed.
    Modules mentioned in `ENFORCED_SETUP_MODULE_ORDER` are processed first. The rest
    are processed in user specified order.
    """
    sorted_modules = list(m for m in ENFORCED_SETUP_MODULE_ORDER if m in setup_modules)
    sorted_modules.extend(
        m for m in setup_modules if m not in ENFORCED_SETUP_MODULE_ORDER
    )
    return sorted_modules


def get_available_setup_modules():
    """Returns a list of available 'discoverable' setup modules."""
    _, dirs, _ = next(os.walk(join(DOTFILES_REPO_ROOT_DIR, "setup/discoverable")))
    setup_modules = [x for x in dirs if x not in IGNORED_DISCOVERABLE_DIRS]
    return sort_by_install_precedence(setup_modules)


def get_installer_module(name: str) -> types.ModuleType | None:
    module_name = f"discoverable.{name}.install"
    module_present = importlib_util.find_spec(module_name) is not None

    if module_present:
        return importlib.import_module(module_name)

    return None


def run_installer(tool_name: str, func_name: str):
    module = get_installer_module(tool_name)
    if module is None:
        print(f"No installer module found for '{tool_name}'. Skipping...")
        return

    func = getattr(module, func_name, None)
    if func is None:
        print(
            f"No function named `{func_name}` found in installer module for "
            f"{tool_name}. Skipping..."
        )
        return

    func()
