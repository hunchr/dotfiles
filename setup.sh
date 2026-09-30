#!/usr/bin/env bash
set -euo pipefail
shopt -s dotglob

type -p brew > /dev/null 2>&1 || (echo 'error: brew not found' && exit 1)

# Load environment variables
[ -f .env ] || cp .env.example .env
. .env

# Install brew formulae and casks
if [ "${1-}" = init ]; then
  # Output of `brew leaves | tr '\n' ' '`
  brew install --formula act ansible ansible-lint automake awscli bash bazel \
    bombardier cmake coreutils curl deno docker-completion e2fsprogs elixir-ls \
    exiftool exiv2 fd ffmpeg findutils fswatch fzf geckodriver gh git gnu-sed \
    gnu-tar go graphviz httpd hyfetch hyperfine ios-deploy jansson \
    jorgelbg/tap/pinentry-touchid jpeg jq jwt-cli kind kubectx libidn \
    libimobiledevice libxslt libyaml llvm mas minio-mc mise mkcert mysql nginx \
    ninja nmap pcre ollama pdftk-java pgvector pinentry-mac postgresql@18 \
    pygments rclone redis ripgrep rustup schemacrawler/tap/schemacrawler \
    shellcheck tmux tree vips wabt wget xcodegen yarn yq yt-dlp zip zlib zsh

  brew install --cask android-studio chromedriver docker-desktop fork \
    git-credential-manager google-chrome handbrake-app libreoffice librewolf \
    mullvad-vpn ngrok obs pgadmin4 proton-drive proton-pass qbittorrent \
    qlvideo raycast signal slack spotify stolendata-mpv the-unarchiver \
    thunderbird tunnelblick vlc whatsapp
fi

# Replace {{VARIABLE}} with value of $VARIABLE
replace_placeholders() {
  while grep -q '{{[A-Z_]\+}}' "$1"; do
    placeholder=$(grep -o '{{[A-Z_]\+}}' "$1" | head -1 | tr -d '{}')
    declare -n value=$placeholder

    if sed --version > /dev/null 2>&1; then
      sed -i "s|{{$placeholder}}|$value|g" "$1"
    else
      sed -i '' "s|{{$placeholder}}|$value|g" "$1"
    fi
  done
}

# Copy config files to home directory
while IFS= read -rd '' file; do
  target=${file/home/~}

  mkdir -p "$(dirname "$target")"
  echo "copy: $file -> ${target/~/'~'}"
  cp "$file" "$target"
  replace_placeholders "$target"
done < <(find home -type f -print0)

# Configure Git
rm -fr ~/.gitconfig.*

for profile in "${GIT_PROFILES[@]}"; do
  declare -n config=GIT_${profile^^}
  declare -n dirs=GIT_${profile^^}_DIR

  echo "create: ~/.gitconfig.$profile"
  printf '[user]\n  name = %s\n  email = %s\n  signingkey = %s\n' \
    "${config[0]}" "${config[1]}" "${config[2]}" >> ~/.gitconfig."$profile"

  # Use SSH instead of GnuPG if signing key is a file
  if [ -f "${config[2]}" ]; then
    printf '[gpg]\n  format = ssh' >> ~/.gitconfig."$profile"
  fi

  for dir in "${dirs[@]}"; do
    printf '[includeIf "gitdir:%s/"]\n  path = %s/.gitconfig.%s\n' \
      "$dir" ~ "$profile" >> ~/.gitconfig
  done
done

# Install Bun
type -p bun > /dev/null 2>&1 || (curl -fsSL https://bun.com/install | bash)
ln -fs ~/.bun/_bun ~/.zfunc

# Install mkcert
cert=~/.localhost-cert.pem

if [ ! -f "$cert" ]; then
  mkcert -install
  mkcert -cert-file "$cert" -key-file ~/.localhost-key.pem localhost
fi

# Install Oh My Zsh plugins
plugin() {
  target=~/.oh-my-zsh/plugins/$(basename "$1")
  [ -d "$target" ] || git clone --depth=1 "https://github.com/$1" "$target"
}

mkdir -p ~/.zfunc
plugin zdharma-continuum/fast-syntax-highlighting
plugin marlonrichert/zsh-autocomplete
exec zsh
