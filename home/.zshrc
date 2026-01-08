fpath+=$HOME/.zfunc
plugins=(fast-syntax-highlighting zsh-autocomplete)

export ANDROID_HOME=$HOME/Library/Android/sdk
export BUN_INSTALL=$HOME/.bun
export CARGO_TARGET_DIR=$HOME/.cargo/target
export CPATH=/usr/local/include:/opt/homebrew/include:/opt/homebrew/opt/llvm/include:/opt/homebrew/opt/postgresql@18/include:$CPATH
export CPPFLAGS='-I/opt/homebrew/opt/llvm/include -I/opt/homebrew/opt/sqlite/include -I/opt/homebrew/opt/postgresql@18/include'
export DISABLE_UNTRACKED_FILES_DIRTY=true
export DISPLAY=localhost:0
export DO_NOT_TRACK=1
export DRIVE="$HOME/Library/Mobile Documents/com~apple~CloudDocs/home"
export EDITOR='code --wait'
export FONTAWESOME_NPM_AUTH_TOKEN={{FONTAWESOME_NPM_AUTH_TOKEN}}
export GPG_TTY=$(tty)
export HOMEBREW_NO_ENV_HINTS=1
export JAVA_HOME='/Applications/Android Studio.app/Contents/jbr/Contents/Home'
export LANG=en_US.UTF-8
export LDFLAGS='-L/opt/homebrew/opt/llvm/lib/c++ -L/opt/homebrew/opt/sqlite/lib -L/opt/homebrew/opt/postgresql@18/lib'
export LIBRARY_PATH=/usr/local/lib:/opt/homebrew/lib:/opt/homebrew/opt/postgresql@18/lib:/opt/homebrew/opt/mysql@8.4/lib:$LIBRARY_PATH
export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"
export PATH="{{PWD}}/bin:$HOME/.cargo/bin:$HOME/go/bin:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/sqlite/bin:/opt/homebrew/opt/postgresql@18/bin:/opt/homebrew/opt/curl/bin:$HOME/.bun/bin:$PATH"
export TZ=UTC
export ZSH=$HOME/.oh-my-zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/opt/homebrew/bin/mise activate zsh)"
. $ZSH/oh-my-zsh.sh

alias b='bun'
alias be='bundle exec'
alias bi='bundle install'
alias bla='bundle lock --add-platform'
alias blr='bundle lock --remove-platform'
alias br='bun run'
alias brwe='brew'
alias bu='bundle update'
alias bua='bundle update --all'
alias c='cargo'
alias cr='cargo r -q'
alias dcd='docker compose down'
alias dce='docker exec -it "$(docker ps -qf name=app-1 -f name=web-1)" bash' 
alias dco='docker compose'
alias dcu='docker compose up -d'
alias dl='cd $HOME/Downloads'
alias dns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias dotf='code "{{PWD}}"'
alias e='code'
alias f='if [ -f bin/fastcheck ]; then bin/fastcheck; else bin/lint; fi'
alias ffcolor='open https://color.firefox.com/?theme=XQAAAAJ6AgAAAAAAAABBKYhm849SCicxcUEYWXcGHf3p79EhVPQ41r7xcfZ9PTtZXOCodCzcptzyX3upVH9adVuj2mXdFr63EzkgliO-MRy-QJvv3UOz8NB6_XLCNEkN6pWzKrg907l38HgqznJdbpzuM6NIBQtjTzdvmSxavrK7qGahlGQ5xWlQEvBlqV0qvHpAum8iaEDF5LZI3giZMaZeLTd8lr9PtdYjRFPqmUfS4LRgX_vqHDL324j_IUPmsDzoS7tmerB6mAHRCdP9BrTchXyXn4z07_4a5EPsTtzsR2VxwSkA7Fsh7cd_wsLLxMownq4oyhjUUjwD_tWVKw'
alias fn='find . -name'
alias fsize='du -sh * | sort -hr'
alias g='git'
alias gitd='find . -name .git -type d'
alias i='cd "$DRIVE/coding"'
alias ip='echo "private: $(ipconfig getifaddr en0)/$(ipconfig getoption en0 subnet_mask | awk -F . '"'"'{print ($1==255)*8+($2==255)*8+($3==255)*8+($4==255)*8}'"'"')\npublic:  $(dig +short myip.opendns.com @resolver1.opendns.com)/32"'
alias l='ls -AFG'
alias lsl='ls {/Library/LaunchAgents,/Library/LaunchDaemons,$HOME/Library/LaunchAgents}'
alias m='bin/rails db:migrate'
alias my='code $HOME/.my.cnf'
alias n='ln -s $HOME/node_modules .'
alias nce='nctl exec app'
alias ncg='nctl get app'
alias ncl='nctl logs app'
alias nco='nctl auth set-org'
alias ncp='nctl auth set-project'
alias neofetch='neowofetch --config $HOME/neofetch.conf'
alias nmp='nmap -Pn -p 1-65535 $(ipconfig getifaddr en0)'
alias pf='bun -b x prettier --log-level warn -w .'
alias pgrestore='pg_restore -OU $USER -cvh localhost latest.dump -d'
alias pinentry='pinentry-mac'
alias quarantine='xattr -d com.apple.quarantine'
alias r='bin/rails'
alias rc='bundle exec rubocop'
alias rd="psql -d postgres -c \"SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname != 'postgres';\" && bin/rails db:drop && bin/rails db:prepare"
alias rl='readlink -f'
alias rlsp='gem i ruby-lsp solargraph'
alias rp='bundle exec rspec'
alias rr='bin/rails routes | grep'
alias rt='bin/rails test'
alias s3='code $HOME/.aws/credentials'
alias s="rg -.Sg '!.git/'"
alias scov='open coverage/index.html'
alias sq='sqlite3'
alias svgo='bun -b x svgo --multipass -o out -f'
alias t='bin/check'
alias treed='tree . -ahno tree.txt -FI ".git|node_modules|tmp" --dirsfirst --du --sort=size'
alias unhide='chflags -R 0 .'
alias up='brew up && brew upgrade --greedy && brew cleanup'
alias v='[[ $(mullvad status) =~ Connected ]] && mullvad disconnect -w || (mullvad connect -w > /dev/null && mullvad status)'
alias z='code $HOME/.zshrc'
