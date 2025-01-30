fpath+=$HOME/.zfunc
plugins=(fast-syntax-highlighting zsh-autocomplete)

export BUN_INSTALL=$HOME/.bun
export CPATH=/usr/local/include:/opt/homebrew/include:/opt/homebrew/opt/llvm/include:/opt/homebrew/opt/mysql@8.4/include:/opt/homebrew/opt/postgresql@17/include:$CPATH
export CPPFLAGS='-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/postgresql@17/include -I/opt/homebrew/opt/mysql@8.4/include'
export DISABLE_UNTRACKED_FILES_DIRTY=true
export DISPLAY=localhost:0
export DO_NOT_TRACK=1
export EDITOR='code --wait'
export FONTAWESOME_NPM_AUTH_TOKEN={{FONTAWESOME_NPM_AUTH_TOKEN}}
export GPG_TTY=$(tty)
export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/home"
export LANG=en_US.UTF-8
export LDFLAGS='-L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/postgresql@17/lib -L/opt/homebrew/opt/mysql@8.4/lib'
export LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib:/opt/homebrew/opt/postgresql@17/lib:/opt/homebrew/opt/mysql@8.4/lib:$LIBRARY_PATH
export PATH=$ICLOUD/coding/bin:$HOME/.cargo/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/postgresql@17/bin:/opt/homebrew/opt/mysql@8.4/bin:$PATH
export RUBYOPT=-W:deprecated
export TZ=UTC
export ZSH=$HOME/.oh-my-zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
. $ZSH/oh-my-zsh.sh
. <(nctl completions -c zsh)
. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias b='bun run'
alias be='bundle exec'
alias bi='bundle install'
alias bsrp='brew services restart postgresql'
alias bu='bundle update'
alias c='code'
alias dcd='docker compose down'
alias dco='docker compose'
alias dcu='docker compose up -d'
alias dl='cd $HOME/Downloads'
alias dotfiles='code {{PWD}}'
alias f='fork .'
alias fsize='du -sh * | sort -hr'
alias g='git'
alias i='cd "$ICLOUD/coding"'
alias ip='echo "private: $(ipconfig getifaddr en0)/$(ipconfig getoption en0 subnet_mask | awk -F . '"'"'{print ($1==255)*8+($2==255)*8+($3==255)*8+($4==255)*8}'"'"')\npublic:  $(dig +short myip.opendns.com @resolver1.opendns.com)/32"'
alias ls='ls -AF'
alias nca='nctl auth set-project'
alias nce='nctl exec app'
alias ncg='nctl get app'
alias ncl='nctl logs app'
alias nosync='ln -s $HOME/node_modules .'
alias pgrestore='pg_restore -OU $USER -cvh localhost latest.dump -d'
alias pinentry='pinentry-mac'
alias quarantine='xattr -d com.apple.quarantine'
alias r='bundle exec rails'
alias rc='bundle exec rubocop'
alias rcompl='gem i solargraph && gem i ruby-lsp'
alias rprod='bundle exec rails assets:precompile && bundle exec rails s -b ssl://localhost:3000?cert=$HOME/.localhost-cert.pem&key=$HOME/.localhost-key.pem&verify_mode=none -e production -p 3000'
alias rprod_db='RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:setup'
alias rr='rails routes | grep'
alias rspec='bundle exec rspec -f documentation'
alias s3cfg='code $HOME/.s3cfg'
alias simplecov='open coverage/index.html'
alias stablediff='cd $HOME/stable-diffusion-webui && ./webui.sh --no-half'
alias svgo='bun -b x svgo -o out --multipass'
alias tree='tree . -ahno tree.txt -FI ".git|node_modules|tmp" --dirsfirst --du --sort=size'
alias zshrc='code $HOME/.zshrc'
