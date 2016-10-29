# This file holds any config involving modifications to $PATH.
#
# Important Notes:
# One would expect this to be stored in `~/.zshenv` (which currently handles setting of
# all other environment variables), but there's a subtle issue in zsh on Arch Linux that
# prevents us from doing so. The issue arises from the following facts:
#
# 1. In the zsh packaged for Arch Linux, `/etc/profile` is sourced from `/etc/zsh/profile`
#   - `/etc/profile` is not actually part of the 'regular' list of startup files for zsh
# 2. `/etc/profile` sets the $PATH variable to some default - overwriting any
#     modifications that were done previously - eg. in `~/.zshenv`
# 3. 'Login shells' will source `/etc/zsh/zprofile`, which will source `/etc/profile`,
#     which will reset $PATH.
#     (Note: tmux creates new windows and panes as login shells by default.)
#
# Thus, to overcome the above, we use `~/.zshenv` for setting all environment variables
# EXCEPT $PATH, which is set here and sourced from our `zshrc`.
#
# References:
# https://lists.archlinux.org/pipermail/arch-general/2013-March/033109.html
# https://bugs.archlinux.org/task/31873
# https://wiki.archlinux.org/index.php/Zsh#Startup.2FShutdown_files
# http://superuser.com/questions/968942/why-does-tmux-create-new-windows-as-login-shells-by-default


# Add fzf binaries to PATH
export PATH="$PATH:$FZF_CONFIG_PATH/fzf/bin"
