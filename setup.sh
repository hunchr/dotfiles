#!/usr/bin/env bash
set -euo pipefail

# Load environment variables
cp -n .env.example .env || true
source .env

[[ -n $GIT_PERSONAL_EMAIL ]] \
  || (echo 'fill out the .env file, then run this command again' && exit 0)

command -v brew &> /dev/null \
  || (echo 'error: homebrew is not installed' && exit 1)

BREW_FORMULAE=${1:-}
CONFIG_DIR=$PWD/.config
mkdir -p "$CONFIG_DIR"

# Prompt user to continue
prompt() {
  echo -n "Do you want to $*? (y/N) "
  read -r response

  [[ $response == y ]] && return 0 || return 1
}

# Install Homebrew formulae
brew_install() {
  [[ $BREW_FORMULAE == -n ]] || brew install "$@"
}

# Copy file and replace {{VARIABLE}} with value of $VARIABLE
cp_env() {
  local file
  local symlink=${2:-}
  file=$CONFIG_DIR/$(basename "$1")

  cp "$1" "$file"
  [[ -n $symlink ]] && ln -fs "$file" "$symlink"

  while grep -q '{{[A-Z_]\+}}' "$file"; do
    var=$(grep -o '{{[A-Z_]\+}}' "$file" | head -1 | tr -d '{}')
    value=$(eval echo "\$$var")

    if sed --version > /dev/null 2>&1; then
      sed -i "s|{{$var}}|$value|g" "$file"
    else
      sed -i '' "s|{{$var}}|$value|g" "$file"
    fi
  done
}

# asdf
if prompt configure asdf; then
  brew_install asdf
  cp_env asdf/.asdfrc "$HOME"
  cp_env asdf/.tool-versions "$HOME"
fi

# Git
if prompt configure Git; then
  brew_install git
  cp_env git/.gitconfig "$HOME"
  cp_env git/.gitignore
  cp_env git/personal.gitconfig
  cp_env git/work.gitconfig
fi

# Zsh
if prompt configure Zsh; then
  brew_install asdf powerlevel10k zsh zsh-autocomplete zsh-syntax-highlighting
  cp_env zsh/.p10k.zsh
  cp_env zsh/.shellcheckrc "$HOME"
  cp_env zsh/.zprofile "$HOME"
  cp_env zsh/.zshenv "$HOME"
  cp_env zsh/.zshrc "$HOME"
fi
