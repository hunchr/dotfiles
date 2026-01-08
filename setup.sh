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
    placeholder=$(grep -o '{{[A-Z_]\+}}' "$1" | head -1 | tr -d '{}')
    value=$(eval echo "\$$placeholder")

    if sed --version > /dev/null 2>&1; then
      sed -i "s|{{$placeholder}}|$value|g" "$1"
    else
      sed -i '' "s|{{$placeholder}}|$value|g" "$1"
    fi
  done
}

# Clone ohmyzsh plugin
plugin() {
  target=$HOME/.oh-my-zsh/plugins/$(basename "$1")
  [ -d "$target" ] || git clone --depth=1 "https://github.com/$1" "$target"
}

# Install brew formulae and casks
if [ "${1-}" = init ]; then
  # Output of `brew leaves | tr '\n' ' '`
  brew install --formula act automake awscli bash bazel bombardier cmake \
    coreutils curl deno docker-completion e2fsprogs elixir-ls exiftool fd \
    ffmpeg findutils fswatch geckodriver gh git gnu-sed gnu-tar go graphviz \
    heroku/brew/heroku  httpd hyfetch hyperfine ios-deploy jansson \
    jorgelbg/tap/pinentry-touchid jpeg jq jwt-cli kind kubectx \
    libimobiledevice libxslt libyaml llvm mas minio-mc mise mkcert mysql nginx \
    ninech/taps/nctl ninja nmap ollama pdftk-java pgvector pinentry-mac \
    postgresql@18 pygments redis ripgrep rustup s3cmd semaphoreci/tap/sem \
    shellcheck tree vips viu wabt wget xcodegen yarn yq yt-dlp zip zsh

  brew install --cask 1password-cli android-studio chromedriver docker-desktop \
    fork git-credential-manager google-chrome handbrake-app libreoffice \
    librewolf mullvad-vpn ngrok obs pgadmin4 proton-drive proton-pass \
    qbittorrent qlvideo raycast signal slack spotify stolendata-mpv \
    the-unarchiver thunderbird tunnelblick vlc whatsapp
fi

# Copy config files to home directory
while IFS= read -rd '' file; do
  target="${file/home/"$HOME"}" 

  mkdir -p "$(dirname "$target")"
  echo "copy: $file -> $target"
  cp "$file" "$target"
  replace_placeholders "$target"
done < <(find home -type f -print0)

# Zsh
mkdir -p "$HOME/.zfunc"
plugin zdharma-continuum/fast-syntax-highlighting
plugin marlonrichert/zsh-autocomplete

# Bun
type -p bun > /dev/null 2>&1 || (curl -fsSL https://bun.sh/install | bash)
ln -fs "$HOME/.bun/_bun" "$HOME/.zfunc"

# mkcert
cert="$HOME/.localhost-cert.pem"
key="$HOME/.localhost-key.pem"

if [ ! -f "$cert" ] || [ ! -f "$key" ]; then
  mkcert -install
  mkcert -cert-file "$cert" -key-file "$key" localhost
fi

exec zsh
