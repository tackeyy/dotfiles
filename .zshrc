# Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8

# PostgreSQL
#
export PGDATA=/usr/local/var/postgres

case ${OSTYPE} in
  # macOS
  darwin*)
  source ~/.zshrc.macos
  ;;
  linux*)
  ¦ source ~/.zshrc.linuxos
  ;;
esac

# Default shell configuration
#
# set prompt
#

case ${UID} in
0)
    PROMPT='%F{green}[%n@%m %d]'
    SPROMPT=$'%B%{\e[31m%}%r is correct? [n,y,a,e]:%{\e[m%}%b '
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT=$'%{\e[37m%}${HOST%%.*} ${PROMPT}'
    ;;
*)
    PROMPT='[%n@%m %d]'
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT=$'%{\e[37m%}${HOST%%.*} ${PROMPT}'
    ;;
esac

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats " %F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT=$PROMPT'${vcs_info_msg_0_}$ '

## aliases
#
alias be='bundle exec'
alias ls='ls -G'
alias ll='ls -l'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'
alias vf='vim +VimFiler'
alias ip_address='ipconfig getifaddr en0'

## set collor and alias
#
alias gls="gls --color"

# auto change directory
#
# setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
#
setopt correct

# compacked complete list display
#
setopt list_packed

# no beep sound when complete list displayed
#
setopt nolistbeep

# no beep
#
setopt no_beep

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes
#   to end of it)
#
bindkey -v

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# predict search
#
# autoload predict-on
# predict-on

## Command history configuration
#
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_ignore_space    # ignore history which start space
setopt hist_ignore_all_dups # ignore dupulicate history
setopt hist_reduce_blanks   # trim space
setopt hist_find_no_dups    # exclude duplicate history in finding

## Completion configuration
#
autoload -U compinit
compinit

case "${TERM}" in
kterm*|xterm*)
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

## zsh editor
#
autoload zed

## history with peco
#
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# set terminal title including current directory
#
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# Tmux
#

if [[ -z "$TMUX" ]]
then
  tmux new-session;
  exit;
fi

# Plugins configuration
#
# FRAMEWORK
#

source $ZPLUG_HOME/init.zsh

# plugins
#
zplug "zplug/zplug"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

# Load the zsh-syntax-highlighting plugin
if [ -f $ZPLUG_HOME/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]
then
  source $ZPLUG_HOME/repos/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
  ZSH_HIGHLIGHT_STYLES[path]=none
fi

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
