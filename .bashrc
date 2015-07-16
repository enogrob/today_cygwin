unset PROMPT_COMMAND
export PS1="\e[35;40m\033[1m\][\w]\\$\[\033[0m\] "
alias ls="ls -FX"
alias mate="e"
alias h="history"
set -o notify
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b /etc/DIR_COLORS`"
    alias ls='ls --color=always'
    alias ll='ls --color=always -l'
    alias la='ls --color=always -A'
    alias less='less -R'
    alias ls='ls --color=always'
    alias grep='grep --color=always'
    alias egrep='egrep --color=always'
    alias fgrep='fgrep --color=always'
    alias zgrep='zgrep --color=always'
    alias tdy='cd ~/TODAY'
    alias tdf='. ~/bin/today_fallback'
    alias tde='cd ~/TODAY;rake today_end'
    alias tda='cd ~/TODAY_Archive;ls -st'
    alias gem='LANG="${LANG%%.*}.BINARY" gem '
    alias traceroute='tracert'
    alias mate='e'
else
    alias ll='ls -l'
    alias la='ls -A'
fi
set -o ignoreeof
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s histappend

export PATH=$PATH:/cygdrive/c/users/eronogu/Documents/_bin:/home/roberto.nogueira/moshell:/home/roberto.nogueira/bin

cd ~/TODAY

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
