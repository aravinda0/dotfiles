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


To [re]install specific things:

```shell
$ python install.py tmux nvim zsh
```


To [re]install only the tool, without any configuration:

```shell
$ python install.py -t tmux
```


To [re]install only the config files, without the tool:

```shell
$ python install.py -c zsh
```


To see what is available for installation:

```shell
$ python install.py --help
```


## Discovery

- For a setup element to be discovered, it must be placed in the [setup/discoverable](https://github.com/aravinda0/dotfiles/tree/master/setup/discoverable)
directory.
- Each item there is a directory named after the tool, containing an
  `install.py` module. eg. `discoverable/my_tool/install.py`.
- The module can define two optional functions:
    - `install_tools()`
    - `install_config()`
- The above configuration would allow us to run:
    ```shell
    $ python install.py my_tool
    ```
