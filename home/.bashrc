#
# ~/.bashrc
#

################################################################################
# Basic Configuration

# Shell must be interactive
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth
export HISTIGNORE="clear:bg:fg:cd:cd -:exit:date:w:* --help"
export HISTSIZE=100000
export HISTTIMEFORMAT="%F %T "

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s histappend

set -o vi

umask 077

################################################################################
# Shell Prompt

color_red="$(tput setaf 1)"
color_green="$(tput setaf 2)"
color_yellow="$(tput setaf 2)"
color_blue="$(tput setaf 4)"
color_orange="$(tput setaf 6)"
font_bold="$(tput bold)"
color_reset="$(tput sgr0)"

if [[ "$UID" == "0" ]]
then
  color_user="$color_red"
  cmd_line="#"
elif [[ -n "$SUDO_USER" ]]
then
  color_user="$color_orange"
  cmd_line="$"
else
  color_user="$color_green"
  cmd_line="$"
fi

exitcode() {
  if [[ "$EXITCODE" != "0" ]]
  then
    echo "$EXITCODE "
  fi
}

if hash git &> /dev/null
then
  git_branch() {
    git branch 2>/dev/null | awk '/^\*/{ print " ("$2")" }'
  }
else
  git_branch() {
    echo ""
  }
fi

PROMPT_COMMAND="EXITCODE=\$?"
PS1="${font_bold}${color_user}\u@\h${color_reset}\
${font_bold}:${color_blue}\w\
${color_orange}\$(git_branch)${color_reset} \$(exitcode)\n$cmd_line "

################################################################################
# Colors

if hash dircolors &>/dev/null
then
  if [[ -r ~/.dircolors ]]
  then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# Manpages
export LESS_TERMCAP_us=$'\E[01;32m'    # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # End underline
export LESS_TERMCAP_so=$'\E[01;44;33m' # Begin standout-mode
export LESS_TERMCAP_se=$'\E[0m'        # End standout-Mode
export LESS_TERMCAP_md=$'\E[01;31m'    # Begin bold
export LESS_TERMCAP_mb=$'\E[01;31m'    # Begin blink
export LESS_TERMCAP_me=$'\E[0m'        # End

# GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

################################################################################
# Environment

GPG_TTY=$(tty)
export GPG_TTY

export EDITOR=vi
if [ -f "/usr/bin/vim" ]
then
  export EDITOR="vim"
  alias vi='vim'
fi
export VISUAL=$EDITOR
export PAGER=less
export LESS='-iMnR'

# Path
for i in ~/.gem/ruby/*/bin
do
  if [[ -d $i ]]
  then
    PATH=$PATH:$i
  fi
done

################################################################################
# Aliases and Functions

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias feh="feh --auto-zoom --sort filename --borderless --scale-down --draw-filename --image-bg black"
alias l='ls -hF --group-directories-first'
alias la='ls -lhAF'
alias ll='ls -hlisF --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias shit='sudo $(history -p \!\!)' 
alias slideshow="feh --fullscreen --auto-zoom --randomize --hide-pointer --slideshow-delay 3"
alias hideprev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
alias env='env | cat -v'
alias pstop='ps -eo user,pid,ppid,pcpu,cpu,pmem,rss,cmd --sort -pcpu --width $COLUMNS | numfmt --header --to=iec --field 7 --padding 6 | cut -c 1-$COLUMNS | head -n $(($LINES-5))'

if [[ -f "~/.bash_aliases" ]]
then
  . ~/.bash_aliases
fi

bcq(){
  bc <<< "$@"
}

crtsh(){
  curl -s "https://crt.sh/?q=%25.${1}&output=json" | jq -r .name_value | sort -u
}
