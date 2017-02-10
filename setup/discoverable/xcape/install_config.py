import string

from plumbum import FG
from plumbum.cmd import cp, sudo, systemctl

import settings
from utils.messaging import echo


unit_file_name = 'xcape_dotfiles.service'

def install_config():
    echo('Building systemd unit file for xcape...')

    unit_file_contents = make_unit_file_contents()

    echo('Installing xcape unit file...')

    install_unit_file(unit_file_contents)

    echo('Enabling service...')

    sudo[systemctl['enable', unit_file_name]] & FG

    echo('xcape config installed!')


def make_unit_file_contents():
    with open('discoverable/xcape/{0}.template'.format(unit_file_name)) as template_file:
        template = string.Template(template_file.read())

        substitutions = {
            'DOTFILES_INSTALL_DIR': settings.DOTFILES_INSTALL_DIR
        }
        unit_file_contents = template.substitute(substitutions)

        return unit_file_contents


def install_unit_file(unit_file_contents):
    temp_file = '/tmp/{0}'.format(unit_file_name)
    target = '/etc/systemd/system/{0}'.format(unit_file_name)

    # Write to temp file, then use plumbum to copy file to system location, which will
    # prompt for sudo access if required
    with open(temp_file, 'w') as unit_file:
        unit_file.write(unit_file_contents)

    sudo[cp[temp_file, target]] & FG
