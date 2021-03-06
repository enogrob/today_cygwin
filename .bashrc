unset PROMPT_COMMAND
export PS1="\e[35;40m\033[1m\][\w]\\$\[\033[0m\] "
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
    alias gitsts='git status -s'
    alias gitlog='git log --pretty=oneline' 
    alias amcnew='touch status_data.txt;touch description.txt;touch trouble_effects.txt;touch trouble_description.txt;touch test_instruction.txt;touch plex_solution.txt;touch asa_solution.txt;touch load_spac_criteria.txt;touch test_data_and_cover_page.txt;touch enclosures.txt;touch notebook.txt'
    alias tshark='tshark -V -r'
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

export PATH=$PATH:/home/roberto.nogueira/moshell:/home/roberto.nogueira/bin
export PATH=$PATH:/cygdrive/c/apa/bin:/cygdrive/c/ProgramData/chocolatey/lib/Elixir/bin:'/cygdrive/c/Program Files/Wireshark'

# latest JDK 7 by Oracle
export JAVA_6_HOME='/cygdrive/c/program files/Java/jdk1.6.0_45'
# latest JDK 7 by Oracle
export JAVA_7_HOME='/cygdrive/c/program files/Java/jdk1.7.0_79'
# latest JDK 8 by Oracle
export JAVA_8_HOME='/cygdrive/c/program files/Java/jdk1.8.0_51'

# default JDK is 8
export JAVA_HOME=$JAVA_8_HOME
export PATH_ORIG=$PATH
export PATH=$JAVA_HOME/bin:$PATH

# Make aliases to switch from one to another
alias java6='export JAVA_HOME=$JAVA_6_HOME;export PATH=$JAVA_HOME/bin:$PATH_ORIG'
alias java7='export JAVA_HOME=$JAVA_7_HOME;export PATH=$JAVA_HOME/bin:$PATH_ORIG'
alias java8='export JAVA_HOME=$JAVA_8_HOME;export PATH=$JAVA_HOME/bin:$PATH_ORIG'

cd ~/TODAY
