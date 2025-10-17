#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

# Load environment variables
[ -f .env ] || cp .env.example .env
. .env

[ -n "$GIT_PERSONAL_EMAIL" ] || (echo 'error: fill out the .env file' && exit 0)
type -p brew > /dev/null 2>&1 || (echo 'error: brew not found' && exit 1)

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

# Clone ohmyzsh plugin
plugin() {
  target=$HOME/.oh-my-zsh/plugins/$(basename "$1")
  [ -d "$target" ] || git clone --depth=1 "https://github.com/$1" "$target"
}

# Install brew formulae and casks
if [ "${1-}" = i ]; then
  brew install --formula act automake awscli bash bazel bombardier cmake \
    coreutils deno docker dotnet e2fsprogs elixir-ls exiftool fd ffmpeg \
    findutils fswatch geckodriver gh git gnu-sed gnu-tar go graphviz \
    heroku/brew/heroku httpd hyfetch hyperfine jpeg jq jwt-cli kind kubectx \
    libyaml llvm mas mise mkcert mysql ninech/taps/nctl ninja nmap nuget \
    ollama pdftk-java pgvector pinentry-mac postgresql@18 pygments redis \
    rustup s3cmd semaphoreci/tap/sem shellcheck tree valkey vips viu wabt wget \
    xcodegen yarn yq yt-dlp zsh

  brew install --cask 1password-cli android-studio chromedriver docker-desktop \
    fork git-credential-manager google-chrome handbrake-app libreoffice \
    librewolf ngrok obs pgadmin4 proton-drive proton-pass protonvpn \
    qbittorrent qlvideo raycast signal slack spotify stolendata-mpv \
    thunderbird tunnelblick vlc whatsapp
fi

# Copy config files to home directory
for node in home/*; do
  cp -fR "$node" "$HOME"
  [ -d "$node" ] || replace_placeholders "$HOME/$(basename "$node")"
done

# Zsh
plugin zdharma-continuum/fast-syntax-highlighting
plugin marlonrichert/zsh-autocomplete

# Bun
type -p bun > /dev/null 2>&1 || (curl -fsSL https://bun.sh/install | bash)
mkdir -p "$HOME/.zfunc"
ln -fs "$HOME/.bun/_bun" "$HOME/.zfunc"

# mkcert
cert="$HOME/.localhost-cert.pem"
key="$HOME/.localhost-key.pem"
if [ ! -f "$cert" ] || [ ! -f "$key" ]; then
  mkcert -install
  mkcert -cert-file "$cert" -key-file "$key" localhost
fi

exec zsh
