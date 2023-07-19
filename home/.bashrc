################################################################################
#
# ~/.bashrc
#
################################################################################

################################################################################
#
# General
#
################################################################################

# Shell must be interactive
[ -z "$PS1" ] && return

export HISTCONTROL=ignoreboth
export HISTIGNORE="c;clear:bg:fg:cd:cd -:exit:date:w:* --help"
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
#
# Shell Prompt
#
################################################################################

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
#
# Colors
#
################################################################################

# Commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls colors
if hash dircolors &>/dev/null
then
  if [[ -r ~/.dircolors ]]
  then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# bat
hash bat &>/dev/null && alias cat='bat -pp'
hash bat &>/dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'" && export MANROFFOPT="-c"

bhelp(){
  "$@" --help 2>&1 | bat --plain --language=help -pp
}

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
#
# Environment
#
################################################################################

GPG_TTY=$(tty)
export GPG_TTY

export EDITOR=vi
if [[ -f "/usr/bin/vim" ]]
then
  export EDITOR="vim"
  alias vi='vim'
fi
export VISUAL=$EDITOR
export PAGER=less
export LESS='-FiMnR'

# Path
for i in ~/.gem/ruby/*/bin ~/.local/bin
do
  if [[ -d $i ]]
  then
    PATH=$PATH:$i
  fi
done


################################################################################
#
# External Tools
#
################################################################################

# lesspipe: make less more friendly for non-text input files
[[ -x "/usr/bin/lesspipe" ]] && eval "$(SHELL=/bin/sh lesspipe)"

# fzf: command-line fuzzy finder
if hash fzf &> /dev/null
then
  for file in \
    "/usr/share/fzf/key-bindings.bash" \
    "/usr/share/doc/fzf/examples/key-bindings.bash" \
    "/usr/share/fzf/completion.bash" \
    "/usr/share/bash-completion/completions/fzf"
  do
    if [[ -r "$file" ]]
    then
      . "$file"
    fi
  done

  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --multi'
  export FZF_DEFAULT_COMMAND='rg --files'
fi


################################################################################
#
# Aliases and Functions
#
################################################################################

alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias base16="basenc --base16"
alias base64url="basenc --base64url"
alias burl='curl -k --proxy http://127.0.0.1:8080'
alias c='clear'
alias duchs='du -sch .[!.]* * |sort -h'
alias ed='ed -v -p "ed> "'
alias env='env | \cat -v'
alias feh="feh --auto-zoom --sort filename --borderless --scale-down --draw-filename --image-bg black"
alias fop='fzf --preview="ls -l {}; file -b {}; echo; head {}" --preview-window=up:30% --bind "enter:execute(xdg-open {})"'
alias grep-email="grep -E -o '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b'"
alias grep-fqdn="grep -o -E '([a-zA-Z0-9._-])+'"
alias grep-ipaddr="grep -o -E '(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'"
alias grep-paragraph='perl -00ne "print if /$1/i"' # Displays paragraph containing matched lines (grep -p on AIX)
alias grep-url="grep -o -E 'https?://[^ ]+'"
alias hideprev='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
alias imagerename="jhead -nf%Y-%m-%d_%H-%M-%S"
alias imagerotate="jhead -autorot"
alias ip="ip --color"
alias ipba="ip --color --brief addr list"
alias ipbl="ip --color --brief link list"
alias l='ls -hF --group-directories-first'
alias la='ls -lhAF'
alias ll='ls -hlisF --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias pomodoro='play -q -n synth sine 480 sine 620 remix 1-2 fade 0 0.5 delay 0.5 repeat 5 2>/dev/null'
alias pstop='ps -eo user,pid,ppid,pcpu,cpu,pmem,rss,cmd --sort -pcpu --width $COLUMNS | numfmt --header --to=iec --field 7 --padding 6 | cut -c 1-$COLUMNS | head -n $(($LINES-5))'
alias qrscan='maim -qs | zbarimg -q --raw - | tee >(xclip -selection clipboard)'
alias shit='sudo $(history -p \!\!)' 
alias slideshow="feh --fullscreen --auto-zoom --randomize --hide-pointer --slideshow-delay 3"
alias ssh-k='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias strip-ansi="sed 's/\x1b\[[0-9;]*m//g'"

if [[ -f "~/.bash_aliases" ]]
then
  . ~/.bash_aliases
fi

androidlogin(){
  local username="$1"
  local password="$2"
  [[ -z "$username" ]] && read -p "Username: " username
  [[ -z "$password" ]] && read -p "Password: " password
  adb shell input text "$username"
  adb shell input keyevent 61 # 61 = Tab
  adb shell input text "$password"
  adb shell input keyevent 66 # 61 = Enter
}

androidtype(){
  local text="$1"
  if [[ -n "$text" ]]
  then
    adb shell input text "$text"
  else
    while read -p "Text: " line
    do
      adb shell input text \""$line"\"
    done
  fi
}

baseconv(){
  # Converts number ($3) from one base ($1) to another base ($2)
  bc <<< "obase=${2^^}; ibase=${1^^}; ${3^^}"
}

bcq() {
  bc -lq <<< "$@"
}

cdf(){
  local path="$(pwd | rev | cut -d/ -f2- | rev | grep -o -E ".*$1[^/]*")"
  echo cd -- "$path"
  cd -- "$path"
}

crtsh() {
  curl -s "https://crt.sh/?q=%25.${1}&output=json" | jq -r ".[].name_value" | sort -u
}

docker-sh(){
  # Lists Docker containers and starts a command (sh by default) in the selected one
  local command="${1:-sh}"
  local containers="$(docker ps | nl -v 0 -w 1)"
  echo -e "Running containers:\n$containers"
  echo -ne "\nSelect: "
  local number
  read number
  ((number++))
  local container="$(sed -n "${number}p" <<< "$containers" | awk '{ print $2 }')"
  echo -e "\nRunning command \"$command\" in container $container ...\n"
  docker exec -it "$container" "$command"
}

f() {
  DIRECTORY="$(find . -type d -ipath "*$@*" -print 2>/dev/null | head -1)"
  cd -- "$DIRECTORY"
}

fakeprompt(){
  local path=${2:-$PWD} # Optionally specify a custom path
  PS1="\[\e]0;${1}:${path}\a\]${font_bold}${color_user}${1}${color_reset}:${font_bold}${color_blue}${path}${color_reset}\n$cmd_line "
}

fd() {
  DIRECTORY="$(find ~/Documents/ -type d -ipath "*$@*" -print 2>/dev/null | head -1)"
  cd -- "$DIRECTORY"
}

fp() {
  DIRECTORY="$(find ~/Documents/Projects/ -type d -iname "*$@*" -print 2>/dev/null | head -1)"
  cd -- "$DIRECTORY"
}

generateuuid(){
  python3 -c 'import uuid; print(uuid.uuid4())'
}

getmydotfiles(){
  local DOTFILES=".bash_profile .bashrc .exrc .inputrc .tmux.conf .vimrc"
  local BASEURL="https://raw.githubusercontent.com/emanuelduss/Configs/master/home/"

  for dotfile in $DOTFILES
  do
    echo "[*] Getting dotfile $HOME/$dotfile"
    wget -q "$BASEURL/$dotfile" -O "$HOME/$dotfile"
  done
}

gitpulldirs(){
  for repo in "$@"
  do
    echo -e "\n[*] Updating $repo..."
    git -C "$repo" pull --ff-only
  done
}

how_in() {
  where="$1"; shift
  IFS=+ curl "https://cht.sh/$where/ $@"
}

infoman(){
  info "$1" | less
}

ip-pub(){
  local ipurl="https://motd.ch/ip.php"
  echo "Public IPv4 Address: $(curl -s -4 -L --write-out "\nLocal IPv4 Addres:   %{local_ip}" $ipurl)"
  echo "Public IPv6 Address: $(curl -s -6 -L --write-out "\nLocal IPv6 Addres:   %{local_ip}" $ipurl)"
}

ipinfo(){
  curl -s -H "Accept: application/json" "https://ipinfo.io/$1"
}

lf(){
  # Fuzzy search filenames containing all arguments case-insensitive in the
  # provided order without knowing the correct filename.
  local strings="$@"
  local regex="${strings// /.*}"
  locate -i --regex "$regex" | grep --color -i -E "$regex"
}

mycd(){
  \cd "${1:-$HOME}"
  ls -lah
}

pa-output(){
  echo "Output devices:"
  pacmd list-sinks | grep -e device.description -e index:
  echo -n "Select: ";
  local number;
  read number;
  pacmd set-default-sink "$number"
}

pretty_csv() {
  # Prettifies CSV input (https://www.stefaanlippens.net/pretty-csv.html)
  column -t -s, -n "$@" | less -F -S -X -K
}

rgvim(){
  rg --color never -l $@ | xargs vim
}

shell-log(){
  local logdir="$HOME/.shell-logs"
  local logfile="$(date "+$logdir/%F_%H-%M-%S_$$")"

  if ! [[ -d "$logdir" ]]
  then
    echo "Logdir $logdir does not exist."
    return 1
  fi

  if [[ "$(ps -ocomm= -p $PPID)" == "script" ]]
  then
    echo "Warning: shell-log is already running!"
    return 1
  else
    script -f --log-timing "${logfile}.time" --log-out "${logfile}.script"
  fi
}

showcolors(){
for i in {30..37}
do
  printf "\e[1;$i;%sm  hello  " {40..47} 0
  echo
done
}

temperature(){
  sed 's/\(.\)..$/.\1°C/' /sys/class/thermal/thermal_zone*/temp
}

xcopy(){
  xclip -in -selection clipboard -f | xclip -in -selection primary -f | xclip -in -selection secondary
}
