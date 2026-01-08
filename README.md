# Dotfiles

A collection of my personal dotfiles for macOS.

## Overview

- `bin`: Added to _$PATH_ in the _.zshrc_ file.
- `etc`: Can be manually copied to _/etc_ with sudo permissions.
- `home`: Copied to _$HOME_.
- `vscode`: Can be manually copied into Visual Studio Code.
- `setup.sh`: Used to set up the dotfiles.

## Setup

> [!CAUTION]
> Running this script will overwrite your current config without any backup.

Make sure you have [Homebrew](https://brew.sh/) installed.

Clone this repo and comment out what you don't need in the `setup.sh` script,
then run it:

```sh
git clone https://github.com/hunchr/dotfiles.git
cd dotfiles
./setup.sh init
```

If you only want to copy the dotfiles and skip installing the
brew formulae and casks, run this instead:

```sh
./setup.sh
```
