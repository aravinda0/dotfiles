# Dotfiles

## Overview

This repository holds configuration and installers for all the tools that I use
in my programming workflow.
The installers are currently Arch Linux specific, but it shouldn't be too hard
to generalize this, which I'll get around to.

Feel free to look around and see if there's something you like. An attempt has
been made to keep things very structured, and most things are explained with
comments.

If you have any suggestions or feedback, feel free to open up an issue or
contact me directly.


## Installation

Clone this repository somewhere and ensure that submodules are fetched too.

```shell
$ git clone https://github.com/ManiacalAce/dotfiles --recurse-submodules
```

There are a few Python dependencies required to use the installer scripts.
Particularly, we use the `plumbum` Python package to make it easier to run shell
commands.

From the project root, run:

```shell
$ [sudo] pip install -r requirements.txt
```


Now you should be ready to run the install scripts.


To install everything (Always run from the `setup` directory):

```shell
$ cd setup/
$ python install.py
```


To install specific things:

```shell
$ python install.py tmux nvim zsh
```


To install only the tool, without any configuration:

```shell
$ python install.py -t tmux
```


To install only the config files, without (re)installing the tool:

```shell
$ python install.py -c zsh
```


To see what is available for installation:

```shell
$ python install.py --help
```


## Discovery

There's a 'discovery' mechanism in place that makes it easy to add installers
for any new tools we might need.

The [setup/discoverable](https://github.com/ManiacalAce/dotfiles/tree/master/setup/discoverable)
directory consists of modules that the installer scripts are 'aware' about.

Each item here is a directory containing two optional Python modules:
- `install_tools.py` - must define a function called `install_tools()`
- `install_config.py` - must define a function called `install_config()`

If you add your own directory here with tool/config installers, you'll be able
to execute it using the install script as usual:

```shell
$ python install.py my_new_config
```
