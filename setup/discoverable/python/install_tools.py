from plumbum import FG

from utils.system.commands import pip_install_global
from utils.messaging import echo


def install_tools():
    install_pew()
    install_ipython()


def install_pew():
    echo('Installing pew...')

    pip_install_global['pew'] & FG

    echo('pew installed!')


def install_ipython():
    echo('Installing IPython...')

    pip_install_global['ipython'] & FG

    echo('IPython installed!')
