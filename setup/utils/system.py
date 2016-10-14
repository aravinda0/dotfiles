from plumbum.cmd import pacman


pacman_install_f = pacman['-S', '--noconfirm']
