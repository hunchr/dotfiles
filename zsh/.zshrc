fpath+=$HOME/.zfunc
plugins=(fast-syntax-highlighting zsh-autocomplete)

BUN_INSTALL=$HOME/.bun
CPPFLAGS='-I/opt/homebrew/opt/llvm/include'
DISABLE_UNTRACKED_FILES_DIRTY=true
DISPLAY=localhost:0
DO_NOT_TRACK=1
EDITOR='code --wait'
FONTAWESOME_NPM_AUTH_TOKEN={{FONTAWESOME_NPM_AUTH_TOKEN}}
GPG_TTY=$(tty)
ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/home"
LANG=en_US.UTF-8
LDFLAGS='-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++'
LIBRARY_PATH=$LIBRARY_PATH:/usr/local/lib:/opt/homebrew/lib
PATH=$ICLOUD/coding/bin:$HOME/.cargo/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/llvm/bin:$PATH
RAILS_UID=$UID
RUBYOPT='-W:deprecated'
TZ=UTC
ZSH=$HOME/.oh-my-zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
. $ZSH/oh-my-zsh.sh
. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias b='bun run'
alias bsrp='brew services restart postgresql'
alias bu='bundle update --bundler && bundle update'
alias c='code'
alias dl="cd $HOME/Downloads"
alias dotfiles='code {{PWD}}'
alias f='fork .'
alias fsize='du -sh * | sort -hr'
alias g='git'
alias i="cd '$ICLOUD/coding'"
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias nosync="ln -s $HOME/node_modules ."
alias pgrestore="pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $USER -d"
alias pinentry='pinentry-mac'
alias quarantine='xattr -d com.apple.quarantine'
alias r='bundle exec rails'
alias rcompl='gem i solargraph && gem i ruby-lsp'
alias rprod="bundle exec rails assets:precompile && bundle exec rails s -e production -b ssl://localhost:3000?cert=$HOME/.localhost-cert.pem&key=$HOME/.localhost-key.pem&verify_mode=none"
alias rprod_db='RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:setup'
alias rr="rails routes | grep"
alias rspec='bundle exec rspec -f documentation'
alias rubocop='bundle exec rubocop'
alias simplecov='open coverage/index.html'
alias stablediff="$HOME/stable-diffusion-webui && ./webui.sh --no-half"
alias svgo='bun -b x svgo -o out --multipass'
alias treedir='tree . -ahq --du --sort=size > tree.txt && code tree.txt'
alias zshrc="code $HOME/.zshrc"
