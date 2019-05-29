from plumbum import FG

from utils.system.commands import pip_install_global
from utils.messaging import echo


python_packages_to_install = [
    'poetry',
    'httpie',
    'ipython',
]


def install_tools():
    echo('First installing pipx...')

    pip_install_global['pipx'] & FG

    echo('pipx installed!')

    # Now import pipx which should be available
    from plumbum.cmd import pipx

    echo('Installing Python packages via pipx...')

    for py_package in python_packages_to_install:
        pipx['install'][py_package] & FG

    echo('Python packages installed')
