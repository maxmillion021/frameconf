#!/usr/bin/env bash
###############################################
#                  Aliases                    #
###############################################

alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias df='df -h'
alias free='free -h'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# ===== Navigation Aliases =====
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias home='cd ~'

# ===== System Aliases =====
alias update='sudo pacman -Syu'
alias ports='netstat -tulanp'
alias mem='free -h'
alias disk='df -h'
alias pget='sudo pacman -S'
alias yget='yay -S'

# ===== Git Aliases =====
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias glog='git log --oneline --graph --decorate'

###############################################
#                  Scripts                    #
###############################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -f /usr/bin/fastfetch ]; then
        fastfetch
fi


###############################################
#                  ENV                        #
###############################################

export EDITOR="vim"
export VISUAL="nvim"
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="%F %T "

###############################################
#                  CMD promt                  #
###############################################

# Colors
RESET="\[\033[0m\]"
RED="\[\033[1;31m\]"
GREEN="\[\033[1;32m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[1;34m\]"
PURPLE="\[\033[1;35m\]"
CYAN="\[\033[1;36m\]"

# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Custom prompt
PS1="${GREEN}\u@\h${RESET}:${BLUE}\w${YELLOW}\$(parse_git_branch)${RESET}\$ "

###############################################
#                  Settings                   #
###############################################

# Enable programmable completion features
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
    fi

# FZF Installation check and setup
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Enable fuzzy auto-completion and key bindings
eval "$(fzf --bash)"

# FZF Configuration
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"

# Enhanced completion triggers
export FZF_COMPLETION_TRIGGER='**'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
        ssh)          fzf --preview 'dig {}'                   "$@" ;;
        *)           fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
}

# File search and open
# Ctrl+F to search files
function fzf-find-file() {
    local file
    file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}') &&
    ${EDITOR:-vim} "$file"
}

bind -x '"\C-f": fzf-find-file'

# Git specific fzf functions
function fzf-git-branch() {
    git branch -a --color=always | grep -v '/HEAD\s' | sort |
    fzf --height 50% --ansi --multi --tac --preview-window right:70% \
        --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
    sed 's/^..//' | cut -d' ' -f1 |
    sed 's#^remotes/##'
}

# Aliases for fzf functions
alias fzfb='fzf-git-branch'
