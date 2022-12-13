# Dotfiles

## Overview

These are my dotfiles and automated system setup scripts. Come in, take a load
off, have a look around.


## Installation

Clone the repo and ensure submodules are fetched as well.

```shell
$ git clone https://github.com/aravinda0/dotfiles --recurse-submodules
```

Switch to the `setup` directory and run the install script.

```shell
$ cd setup/
$ python install.py
```


To (re)install specific things:

```shell
$ python install.py tmux nvim zsh
```


To (re)install only the tool, without any configuration:

```shell
$ python install.py -t tmux
```


To (re)install only the config files, without (re)installing the tool:

```shell
$ python install.py -c zsh
```


To see what is available for installation:

```shell
$ python install.py --help
```


## Discovery

There's a 'discovery' mechanism in place that detects things inside the [setup/discoverable](https://github.com/aravinda0/dotfiles/tree/master/setup/discoverable)
directory.


Each item there is a directory containing two optional Python modules:
- `install_tools.py` - must define a function called `install_tools()`
- `install_config.py` - must define a function called `install_config()`

If you add your own directory here with tool/config installers, you'll be able
to execute it using the install script as usual:

```shell
$ python install.py my_new_config
```
