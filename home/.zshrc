fpath+=$HOME/.zfunc
plugins=(fast-syntax-highlighting zsh-autocomplete)

export BUN_INSTALL=$HOME/.bun
export CPATH=/usr/local/include:/opt/homebrew/include:/opt/homebrew/opt/llvm/include:/opt/homebrew/opt/postgresql@17/include:$CPATH
export CPPFLAGS='-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/sqlite/include -I/opt/homebrew/opt/postgresql@17/include'
export DISABLE_UNTRACKED_FILES_DIRTY=true
export DISPLAY=localhost:0
export DO_NOT_TRACK=1
export EDITOR='code --wait'
export FONTAWESOME_NPM_AUTH_TOKEN={{FONTAWESOME_NPM_AUTH_TOKEN}}
export GPG_TTY=$(tty)
export ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs/home"
export LANG=en_US.UTF-8
export LDFLAGS='-L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/sqlite/lib -L/opt/homebrew/opt/postgresql@17/lib'
export LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib:/opt/homebrew/opt/postgresql@17/lib:/opt/homebrew/opt/mysql@8.4/lib:$LIBRARY_PATH
export PATH=$ICLOUD/coding/bin:$HOME/.cargo/bin:/opt/homebrew/opt/gnu-sed/libexec/gnubin:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/sqlite/bin:/opt/homebrew/opt/postgresql@17/bin:$HOME/.bun/bin:$PATH
export RUBYOPT=-W:deprecated
export TZ=UTC
export ZSH=$HOME/.oh-my-zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/mise activate zsh)"
. $ZSH/oh-my-zsh.sh

alias b='bun run'
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias c='code'
alias dcd='docker compose down'
alias dce='docker exec -it "$(docker ps -qf name=app-1 -f name=web-1)" bash' 
alias dco='docker compose'
alias dcu='docker compose up -d'
alias dl='cd $HOME/Downloads'
alias dotfiles='code "{{PWD}}"'
alias f='fork .'
alias ffcolor='open https://color.firefox.com/?theme=XQAAAAJ6AgAAAAAAAABBKYhm849SCicxcUEYWXcGHf3p79EhVPQ41r7xcfZ9PTtZXOCodCzcptzyX3upVH9adVuj2mXdFr63EzkgliO-MRy-QJvv3UOz8NB6_XLCNEkN6pWzKrg907l38HgqznJdbpzuM6NIBQtjTzdvmSxavrK7qGahlGQ5xWlQEvBlqV0qvHpAum8iaEDF5LZI3giZMaZeLTd8lr9PtdYjRFPqmUfS4LRgX_vqHDL324j_IUPmsDzoS7tmerB6mAHRCdP9BrTchXyXn4z07_4a5EPsTtzsR2VxwSkA7Fsh7cd_wsLLxMownq4oyhjUUjwD_tWVKw'
alias fsize='du -sh * | sort -hr'
alias g='git'
alias i='cd "$ICLOUD/coding"'
alias ip='echo "private: $(ipconfig getifaddr en0)/$(ipconfig getoption en0 subnet_mask | awk -F . '"'"'{print ($1==255)*8+($2==255)*8+($3==255)*8+($4==255)*8}'"'"')\npublic:  $(dig +short myip.opendns.com @resolver1.opendns.com)/32"'
alias l='ls -AFG'
alias nca='nctl auth set-project'
alias nce='nctl exec app'
alias ncg='nctl get app'
alias ncl='nctl logs app'
alias nmapp='nmap -Pn -p 1-65535 $(ipconfig getifaddr en0)'
alias nosync='ln -s $HOME/node_modules .'
alias pgrestore='pg_restore -OU $USER -cvh localhost latest.dump -d'
alias pinentry='pinentry-mac'
alias quarantine='xattr -d com.apple.quarantine'
alias r='bundle exec rails'
alias rc='bundle exec rubocop'
alias rcompl='gem i solargraph && gem i ruby-lsp'
alias rp='bundle exec rspec -f d'
alias rprod='bundle exec rails assets:precompile && bundle exec rails s -b "ssl://localhost:3000?cert=$HOME/.localhost-cert.pem&key=$HOME/.localhost-key.pem&verify_mode=none" -e production -p 3000'
alias rprod_db='RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:reset'
alias rr='bundle exec rails routes | grep'
alias rt='bundle exec rails test'
alias s3cfg='code $HOME/.s3cfg'
alias scov='open coverage/index.html'
alias sqlite='sqlite3'
alias stablediff='cd $HOME/stable-diffusion-webui && ./webui.sh --no-half'
alias svgo='bun -b x svgo -o out --multipass'
alias treedir='tree . -ahno tree.txt -FI ".git|node_modules|tmp" --dirsfirst --du --sort=size'
alias unhide='chflags -R 0 .'
alias zshrc='code $HOME/.zshrc'
