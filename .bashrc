# ~/.bashrc optimizado

# Ejecutar solo en shells interactivos
case $- in
    *i*) ;;
      *) return;;
esac

# === HISTORIAL ===
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

# === PROMPT ===
color_prompt=yes
if [ "$color_prompt" = yes ]; then
    PS1='\[\033[1;32m\]\w\[\033[1;36m\] 󰣇 \[\033[1;34m\]❯ \[\033[1;37m\]'
else
    PS1='\w\$ '
fi

# === LS & GREP COLORES ===
if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'
fi



# === ALIAS ===
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias cat='bat --style=plain --paging=never'
alias rm='rm -rfv'
alias cp='cp -rfv'


# === BASH COMPLETION ===
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# === ALIAS EXTERNOS ===
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

