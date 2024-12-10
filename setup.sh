#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

# Load environment variables
[ -f .env ] || cp .env.example .env
. .env

[ -n "$GIT_PERSONAL_EMAIL" ] || (echo 'error: fill out the .env file' && exit 0)
command -v brew > /dev/null 2>&1 || (echo 'error: brew not found' && exit 1)
mkdir -p "$HOME/.zfunc"

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

# Copy config files to home directory
dotfiles() {
  for path in "$@"; do
    for node in "$path"/*; do
      cp -fR "$node" "$HOME"
      [ -d "$node" ] || replace_placeholders "$HOME/$(basename "$node")"
    done
  done
}

# Install brew casks
casks() {
  for cask in "$@"; do
    [ -d "/applications/$(echo "$cask" | tr '-' ' ').app" ] \
      || brew install --cask --force "$cask"
  done
}

# Install brew formulae
formulae() {
  brew_bin=$(brew --prefix)/bin

  for formulae in "$@"; do
    [ -f "$brew_bin/$formulae" ] || brew install "$formulae"
  done
}

# Install and configure everything
dotfiles asdf git zsh
casks docker fork handbrake libreoffice librewolf obs postman proton-drive \
  proton-pass protonvpn qbittorrent raycast signal vlc whatsapp
formulae asdf automake bash brotli chromedriver cmake deno docker fd ffmpeg \
  geckodriver gh git go gpg jq julia mkcert ninja pinentry-mac pkgconf \
  shellcheck tree vips wget xz yq zsh

# Bun
command -v bun > /dev/null 2>&1 || (curl -fsSL https://bun.sh/install | bash)
ln -fs "$HOME/.bun/_bun" "$HOME/.zfunc"

# mkcert
cert="$HOME/.localhost-cert.pem"
key="$HOME/.localhost-key.pem"
if [ ! -f "$cert" ] || [ ! -f "$key" ]; then
  mkcert -install
  mkcert -cert-file "$cert" -key-file "$key" localhost
fi

exec zsh
