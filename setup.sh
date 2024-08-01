#!/usr/bin/env bash
set -euo pipefail

# Load environment variables
cp -n .env.example .env || true
source .env

[[ -n $GIT_PERSONAL_EMAIL ]] \
  || (echo fill out the .env file, then run this command again && exit 0)

CONFIG_DIR=$PWD/.config
mkdir -p $CONFIG_DIR

# Prompt user to continue
prompt() {
  echo -n "Do you want to $@? (y/N) "
  read -r response

  [[ $response == y ]] && return 0 || return 1
}

# Copy file and replace {{VARIABLE}} with value of $VARIABLE
cp_env() {
  local file=$CONFIG_DIR/$(basename $1)
  local symlink=${2:-}
  
  cp $1 $file
  [[ -n $symlink ]] && echo ln -fs $file $symlink && ln -fs $file $symlink

  while grep -q '{{[A-Z_]\+}}' $file; do
    var=$(grep -o '{{[A-Z_]\+}}' $file | head -1 | tr -d '{}')
    value=$(eval echo \$$var)
    sed -i "s|{{$var}}|$value|g" $file
  done
}

# Git
if prompt configure Git; then
  cp_env git/.gitconfig $HOME
  cp_env git/.gitignore
  cp_env git/personal.gitconfig
  cp_env git/work.gitconfig
fi
