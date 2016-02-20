#
# ~/.bashrc
#

# Shell must be interactive
[ -z "$PS1" ] && return

SOURCEFILES="/etc/bashrc \
  /etc/bash_completion \
  /usr/share/bash-completion/bash_completion \
  /usr/share/doc/pkgfile/command-not-found.bash \
  /usr/share/git/completion/git-completion.bash \
  ~/.bash_aliases"

for file in $SOURCEFILES
do
  if [ -f "$file" ]
  then
    . "$file"
  fi
done
unset SOURCEFILES

# Bash settings
export HISTTIMEFORMAT="%F %T "
export HISTSIZE=100000
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:w:* --help"
export HISTCONTROL=ignoreboth
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend
set -o vi

# Path
for i in ~/.gem/ruby/*/bin
do
  if [[ -d $i ]]
  then
    PATH=$PATH:$i
  fi
done

# Prompt
color_red="$(tput setaf 1)"
color_green="$(tput setaf 2)"
color_yellow="$(tput setaf 2)"
color_blue="$(tput setaf 4)"
color_orange="$(tput setaf 6)"
font_bold="$(tput bold)"
color_reset="$(tput sgr0)"

git_branch() {
  git branch 2>/dev/null | awk '/^\*/{ print "("$2")" }'
}

if [ "$UID" -eq 0 ]
then
  color_user="$color_red"
else
  color_user="$color_green"
fi

PS1="${font_bold}${color_user}\u@\h${color_reset}\
${font_bold}:${color_blue}\w \
${color_orange}$(git_branch)${color_reset}\n\$ "

# Colors
if [ -x /usr/bin/dircolors ]
then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Colored Manpages
export LESS_TERMCAP_us=$'\E[01;32m'    # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # End underline
export LESS_TERMCAP_so=$'\E[01;44;33m' # Begin standout-mode
export LESS_TERMCAP_se=$'\E[0m'        # End standout-Mode
export LESS_TERMCAP_md=$'\E[01;31m'    # Begin bold
export LESS_TERMCAP_mb=$'\E[01;31m'    # Begin blink
export LESS_TERMCAP_me=$'\E[0m'        # End

# Colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Environment
export EDITOR=vi
export VISUAL=$EDITOR
export PAGER=less
export LESS='-iMnR'

GPG_TTY=$(tty)
export GPG_TTY

if [ -f "/usr/bin/vim" ]
then
  export EDITOR="vim"
  alias vi='vim'
fi

# Alias
alias c='clear'
alias feh="feh --auto-zoom --sort filename --borderless --scale-down --draw-filename --image-bg black"
alias l='ls -hF --group-directories-first'
alias la='ls -lhAF'
alias ll='ls -hlisF --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias pickcolor="zenity --color-selection | xclip"
alias pomodoro="sleep 25m && play -q -n synth sine 480 sine 620 remix 1-2 fade 0 0.5 delay 0.5 repeat 5"
alias shit='sudo $(history -p \!\!)' 
alias slideshow="feh --fullscreen --auto-zoom --randomize --hide-pointer --slideshow-delay 3"
alias urxvtdemo="urxvt -geometry 70x20 +tr -bg '#232323' -fg white -fn 'xft:Terminus:size=18'"
alias wlanscan='sudo iwlist wlp2s0 scan | grep -e Address -e Channel\: -e Encryption -e ESSID -e IEEE -e Quality'
alias hideprev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'

awkalc() {
  echo true | awk "{print $*}"
}
bcq(){
  bc <<< "$@"
}

umask 077
