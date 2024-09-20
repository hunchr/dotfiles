PROMPT="%{$fg[blue]%}%c%{$reset_color%}"
PROMPT+=' $(git_prompt_info)'
PROMPT+="%(?:%{$fg[green]%}%1{❯%}:%{$fg[red]%}%1{❯%})%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}%1{*%}"
ZSH_THEME_GIT_PROMPT_CLEAN=''
