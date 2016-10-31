from plumbum.cmd import pacman, sudo


pacman_install_f = sudo[pacman['-S', '--noconfirm']]
