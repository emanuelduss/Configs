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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"



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
  for file in "/usr/share/git/git-prompt.sh" \
    "/usr/share/git/completion/git-prompt.sh" \
    "/usr/share/git-core/contrib/completion/git-prompt.sh" \
    "/usr/share/git/completion/git-prompt.sh" \
    "/usr/lib/git-core/git-sh-prompt"
  do
    if [[ -r "$file" ]]
    then
      . "$file"
      GIT_PS1_SHOWDIRTYSTATE=true
      GIT_PS1_SHOWSTASHSTATE=true
      GIT_PS1_SHOWUNTRACKEDFILES=true
      GIT_PS1_SHOWUPSTREAM="auto"
      break
    else
      __git_ps1() {
        git branch 2>/dev/null | awk '/^\*/{ print " ("$2")" }'
      }
    fi
  done
else
  __git_ps1() {
    echo ""
  }
fi

PROMPT_COMMAND="EXITCODE=\$?"
PS1="${font_bold}${color_user}\u@\H${color_reset}\
${font_bold}:${color_blue}\w\
${color_orange}\$(__git_ps1)${color_reset} \$(exitcode)\n$cmd_line "

# Window Title
PS1="\[\e]0;\u@\H:\w\a\]$PS1"

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
for i in ~/.gem/ruby/*/bin ~/.local/bin
do
  if [[ -d $i ]]
  then
    PATH=$PATH:$i
  fi
done

################################################################################
# Aliases and Functions

alias ls='ls --color=auto'
alias ed='ed -v -p "ed> "'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias c='clear'
alias duchs='du -sch .[!.]* * |sort -h'
alias feh="feh --auto-zoom --sort filename --borderless --scale-down --draw-filename --image-bg black"
alias l='ls -hF --group-directories-first'
alias la='ls -lhAF'
alias ll='ls -hlisF --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias shit='sudo $(history -p \!\!)' 
alias slideshow="feh --fullscreen --auto-zoom --randomize --hide-pointer --slideshow-delay 3"
alias hideprev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
alias env='env | cat -v'
alias pstop='ps -eo user,pid,ppid,pcpu,cpu,pmem,rss,cmd --sort -pcpu --width $COLUMNS | numfmt --header --to=iec --field 7 --padding 6 | cut -c 1-$COLUMNS | head -n $(($LINES-5))'
alias ip="ip --color"
alias ipba="ip --color --brief addr list"
alias ipbl="ip --color --brief link list"

if [[ -f "~/.bash_aliases" ]]
then
  . ~/.bash_aliases
fi

xcp() {
  read input
  echo "$input" | xclip -selection primary
  echo "$input" | xclip -selection secondary
  echo "$input" | xclip -selection clipboard
}

bcq() {
  bc <<< "$@"
}

crtsh() {
  curl -s "https://crt.sh/?q=%25.${1}&output=json" | jq -r ".[].name_value" | sort -u
}

cdf(){
  local path="$(pwd | rev | cut -d/ -f2- | rev | grep -o -E ".*$1[^/]*")"
  echo cd -- "$path"
  cd -- "$path"
}

mycd(){
  \cd "${1:-$HOME}"
  ls -lah
}
alias cd=mycd

f() {
  DIRECTORY="$(find . -type d -ipath "*$@*" -print 2>/dev/null | head -1)"
  cd -- "$DIRECTORY"
}

fd() {
  DIRECTORY="$(find ~/Documents/ -type d -ipath "*$@*" -print 2>/dev/null | head -1)"
  cd -- "$DIRECTORY"
}

fp() {
  DIRECTORY="$(find ~/Documents/Projects/ -type d -iname "*$@*" -print 2>/dev/null | head -1)"
  cd -- "$DIRECTORY"
}

how_in() {
  where="$1"; shift
  IFS=+ curl "https://cht.sh/$where/ $@"
}

infoman(){
  info "$1" | less
}

lf(){
  # Fuzzy search filenames containing all arguments case-insensitive in the
  # provided order without knowing the correct filename.
  local strings="$@"
  local regex="${strings// /.*}"
  locate -i --regex "$regex" | grep --color -i -E "$regex"
}

rgvim(){
  rg --color never -l $@ | xargs vim
}

getmydotfiles(){
  local DOTFILES=".bash_profile .bashrc .exrc .gdbinit .gitconfig .inputrc .screenrc .tmux.conf .vimrc"
  local BASEURL="https://raw.githubusercontent.com/mindfuckup/Configs/master/home/"

  for dotfile in $DOTFILES
  do
    echo "[*] Getting dotfile $HOME/$dotfile"
    wget -q "$BASEURL/$dotfile" -O "$HOME/$dotfile"
  done
}
