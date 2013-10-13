########################################################################
#
# ~/.bashrc
# Konfigurationsdatei für die Bash
#
########################################################################


########################################################################
# Sourcen laden

# Nur laden, wenn interaktive Session
[ -z "$PS1" ] && return

SOURCEFILES="/etc/bashrc \
  /etc/bash_completion \
  /usr/share/doc/pkgfile/command-not-found.bash \
  /usr/share/git/completion/git-completion.bash \
  ~/.bash_aliases"

for file in "$SOURCEFILES"
do
  if [ -f "$file" ]
  then
    . "$file"
  fi
done
unset SOURCEFILES


########################################################################
# Bash Settings

set -o vi

# History
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=1048576
export HISTFILE="$HOME/.bash_history-`uname -n`"
export HISTCONTROL=ignoreboth # Ignoriere doppelte Eingaben und Eingaben, welche mit einem Whitespace beginnen
shopt -s histappend      # Befehle an der History anhängen statt überschr.
shopt -s checkwinsize    # LINES unc COLUMNS nach jedem Command prüfen und upaten

# Prompt PS1
if [ "$UID" -eq 0 ]
then
  PS1="${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\n# "
else
  PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\n$ "
fi


########################################################################
# Variabeln
export EDITOR=vi
export VISUAL=$EDITOR
export PAGER=less

if [ -x "/usr/bin/lesspipe.sh" ]
then
  eval `/usr/bin/lesspipe.sh`
fi
export LESS='-iMnR'

if [ -f "/usr/bin/vim" ]
then
  export EDITOR="vim"
  alias vi='vim'
fi


########################################################################
# Farben

# Farben für ls
if [ -x /usr/bin/dircolors ]
then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Farben für Befehle
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Farbige Manpages (Bedeutungen man termcap)
export LESS_TERMCAP_us=$'\E[01;32m'       # Beginn unterstrichen
export LESS_TERMCAP_ue=$'\E[0m'           # Ende unterstrichen
export LESS_TERMCAP_so=$'\E[01;44;33m'    # Beginn Standout-Mode
export LESS_TERMCAP_se=$'\E[0m'           # Ende Standout-Mode
export LESS_TERMCAP_md=$'\E[01;31m'       # Start fett
export LESS_TERMCAP_mb=$'\E[01;31m'       # Start blinken
export LESS_TERMCAP_me=$'\E[0m'           # Ende alles


########################################################################
# Aliase

alias l='ls -hF --group-directories-first'
alias la='ls -lhAF'
alias ll='ls -hlisF --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias more='less'
alias c='clear'
alias wlanscan='sudo iwlist wlan0 scan | grep -e Address -e Channel\: -e Encryption -e ESSID -e IEEE -e Quality'
alias slideshow="feh --fullscreen --auto-zoom --randomize --hide-pointer --slideshow-delay 3"
alias feh="feh --auto-zoom --sort filename --borderless --scale-down --draw-filename --image-bg black"
alias pickcolor="zenity --color-selection | xclip"
alias urxvtdemo="urxvt -geometry 70x20 +tr -bg '#232323' -fg white -fn 'xft:Terminus:size=18'"


########################################################################
# Funktionen

wiki() {
  if [ -n "$1" ]
  then
    dig +ignore +short $1.wp.dg.cx TXT
  else
    echo Bitte einen Begriff angeben.
  fi
}

awkalc() {
  echo true | awk "{print $*}"
}

# Wie grep -p unter AIX (grep absatzweise durch Leerzeile getrennt)
grepp() {
  if [ -z "$1" -o -z "$2" ]
  then
    echo "Usage: grepp pattern file";
  else
    perl -00ne "print if /$1/i" < $2
  fi
}

# EOF
