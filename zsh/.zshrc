fpath+=$HOME/.zfunc

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source {{CONFIG_DIR}}/.p10k.zsh
source $HOME/.bun/_bun
. /opt/homebrew/opt/asdf/libexec/asdf.sh

alias b='bun run'
alias bsrp='brew services restart postgresql'
alias bu='bundle update --bundler && bundle update'
alias c='code'
alias dl="cd $HOME/Downloads"
alias f='fork .'
alias fsize='du -sh * | sort -hr'
alias g='git'
alias i="cd '$ICLOUD/coding'"
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'
alias nosync="ln -s $HOME/node_modules ."
alias pgrestore='pg_restore --verbose --clean --no-acl --no-owner -h localhost -U chr -d'
alias pinentry='pinentry-mac'
alias quarantine='xattr -d com.apple.quarantine'
alias r='bundle exec rails'
alias rcompl='gem i solargraph && gem i ruby-lsp'
alias rprod='bundle exec rails assets:precompile && bundle exec rails s -e production -b "ssl://127.0.0.1:3939?key={{PWD}}/tls/key.pem&cert={{PWD}}/tls/cert.pem&verify_mode=none"'
alias rprod_db='RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop db:setup'
alias rr="rails routes | grep"
alias rspec='bundle exec rspec -f documentation'
alias rubocop='bundle exec rubocop'
alias simplecov='open coverage/index.html'
alias stablediff="$HOME/stable-diffusion-webui && ./webui.sh --no-half"
alias svgo='bunx --bun svgo -o out --multipass'
alias treedir='tree . -ahq --du --sort=size > tree.txt && code tree.txt'
alias zshrc='code {{CONFIG_DIR}}/.zshrc'
