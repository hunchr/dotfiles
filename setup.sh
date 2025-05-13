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

# Clone ohmyzsh plugin
plugin() {
  target=$HOME/.oh-my-zsh/plugins/$(basename "$1")
  [ -d "$target" ] || git clone --depth=1 "https://github.com/$1" "$target"
}

# Install brew formulae and casks
if [ "${1-}" = i ]; then
  brew install --formula asdf automake awscli bash bazel cmake coreutils deno \
    docker exiftool fd ffmpeg findutils geckodriver gh git gnu-sed go \
    handbrake jpeg jq julia kind libavif libyaml llvm mas mkcert mysql nctl \
    ninja nmap parallel pdftk-java pinentry-mac postgresql@17 pygments redis \
    rustup s3cmd shellcheck tree vips wget yarn yq zsh
  brew install --cask 1password-cli chromedriver docker fork google-chrome \
    handbrake libreoffice librewolf obs pgadmin4 postman proton-drive \
    proton-pass protonvpn qbittorrent qlvideo raycast signal slack spotify \
    vlc whatsapp
fi

# Copy dotfiles
dotfiles git mise zsh

# Zsh
plugin zdharma-continuum/fast-syntax-highlighting
plugin marlonrichert/zsh-autocomplete

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
