# Dotfiles

A collection of my personal dotfiles for macOS.

## Setup

Make sure you have [Homebrew](https://brew.sh/) installed.

Clone this repo and run the setup script:

```sh
git clone https://github.com/hunchr/dotfiles.git
cd dotfiles
./setup.sh
```

You can also use the `-n` flag if you don't want to install the brew formulae:

```sh
./setup.sh -n
```

> [!CAUTION]
> This script will ask what you want to configure (i.e. `y/n`). When
> accepting, your current configuration will be overwritten without any backup.
