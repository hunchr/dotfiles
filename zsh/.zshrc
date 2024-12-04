fpath+=$HOME/.zfunc
plugins=(fast-syntax-highlighting zsh-autocomplete)

export BUN_INSTALL=$HOME/.bun
export CPPFLAGS='-I/opt/homebrew/opt/llvm/include'
export DISABLE_UNTRACKED_FILES_DIRTY=true
export DISPLAY=localhost:0
export DO_NOT_TRACK=1
export EDITOR='code --wait'
export FONTAWESOME_NPM_AUTH_TOKEN={{FONTAWESOME_NPM_AUTH_TOKEN}}
export GPG_TTY=$(tty)
export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/home"
export LANG=en_US.UTF-8
export LDFLAGS='-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++'
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib:/opt/homebrew/lib
export PATH=$ICLOUD/coding/bin:$HOME/.cargo/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/llvm/bin:$PATH
export RAILS_UID=$UID
export RUBYOPT='-W:deprecated'
export TZ=UTC
export ZSH=$HOME/.oh-my-zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
. $ZSH/oh-my-zsh.sh
. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias b='bun run'
alias bsrp='brew services restart postgresql'
alias bu='bundle update'
alias c='code'
alias dco='docker compose'
alias dl="cd $HOME/Downloads"
alias dotfiles='code {{PWD}}'
alias f='fork .'
alias fsize='du -sh * | sort -hr'
alias g='git'
alias i="cd '$ICLOUD/coding'"
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias ls="ls -AF"
alias nosync="ln -s $HOME/node_modules ."
alias pgrestore="pg_restore -OU $USER -cvh localhost latest.dump -d"
alias pinentry='pinentry-mac'
alias quarantine='xattr -d com.apple.quarantine'
alias r='bundle exec rails'
alias rc='bundle exec rubocop'
alias rcompl='gem i solargraph && gem i ruby-lsp'
alias rprod="bundle exec rails assets:precompile && bundle exec rails s -e production -b ssl://localhost:3000?cert=$HOME/.localhost-cert.pem&key=$HOME/.localhost-key.pem&verify_mode=none"
alias rprod_db='RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:setup'
alias rr="rails routes | grep"
alias rspec='bundle exec rspec -f documentation'
alias simplecov='open coverage/index.html'
alias stablediff="cd $HOME/stable-diffusion-webui && ./webui.sh --no-half"
alias svgo='bun -b x svgo -o out --multipass'
alias tree='tree . -ahno tree.txt -FI ".git|node_modules|tmp" --dirsfirst --du --sort=size'
alias zshrc="code $HOME/.zshrc"
