#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

# Load environment variables
[ -f .env ] || cp .env.example .env
. .env

[ -n "$GIT_PERSONAL_EMAIL" ] || (echo 'error: fill out the .env file' && exit 0)
command -v brew > /dev/null 2>&1 || (echo 'error: brew not found' && exit 1)
mkdir -p "$HOME/.zfunc"

# Install Homebrew formulae if not already installed
brew_install() {
  brew_bin=$(brew --prefix)/bin

  for pkg in "$@"; do
    find "$brew_bin/$pkg" > /dev/null 2>&1 || brew install "$pkg"
  done
}

exist() {
  command -v "$1" > /dev/null 2>&1
}

# Replace {{VARIABLE}} with value of $VARIABLE
replace_placeholders() {
  while grep -q '{{[A-Z_]\+}}' "$1"; do
    var=$(grep -o '{{[A-Z_]\+}}' "$1" | head -1 | tr -d '{}')
    value=$(eval echo "\$$var")

    if sed --version > /dev/null 2>&1; then
      sed -i "s|{{$var}}|$value|g" "$1"
    else
      sed -i '' "s|{{$var}}|$value|g" "$1"
    fi
  done
}

# Copy each node in config directory to target
configure() {
  for path in "$@"; do
    for node in "$path"/*; do
      cp -fR "$node" "$HOME"
      [ -d "$node" ] || replace_placeholders "$HOME/$(basename "$node")"
    done
  done
}

# Install formulae and configure dotfiles
brew_install asdf bash cmake fd git gpg mkcert pinentry-mac jq \
  tree vips xz yq zsh
configure asdf git zsh

# Bun
exist bun || (curl -fsSL https://bun.sh/install | bash)
ln -fs "$HOME/.bun/_bun" "$HOME/.zfunc"

# mkcert
cert="$HOME/.localhost-cert.pem"
key="$HOME/.localhost-key.pem"
if [ ! -f "$cert" ] || [ ! -f "$key" ]; then
  mkcert -install
  mkcert -cert-file "$cert" -key-file "$key" localhost
fi

exec zsh
