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
color_yellow="$(tput setaf 3)"
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
  [[ "$EXITCODE" != "0" ]] && echo "$EXITCODE "
}

if hash git &> /dev/null
then
  __git_ps1() {
    local branch="$(git branch --show-current 2>/dev/null)"
    [[ -n "$branch" ]] && echo "($branch) "
  }
else
  __git_ps1() {
    true
  }
fi

PROMPT_COMMAND="PROMPT_COMMAND='EXITCODE=\$?;echo'"
PS1="${font_bold}${color_user}\u@\H${color_reset}\
${font_bold}:${color_blue}\w${color_orange} \$(__git_ps1)${color_reset}${color_red}\$(exitcode)${color_yellow}\$(date '+[%F %R]')${color_reset}\n$cmd_line "

# Window Title
PS1="\[\e]0;\u@\H:\w\a\]$PS1"


################################################################################
#
# Colors
#
################################################################################

# General
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# ls
if hash dircolors &>/dev/null
then
  if [[ -r "~/.dircolors" ]]
  then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# bat
if hash bat &>/dev/null
then
  alias cat="bat -pp"

  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export MANROFFOPT="-c"

  bhelp(){
    "$@" --help 2>&1 | bat --plain --language=help -pp
  }
fi

# man
export LESS_TERMCAP_us=$'\E[01;32m'    # Begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # End underline
export LESS_TERMCAP_so=$'\E[01;44;33m' # Begin standout-mode
export LESS_TERMCAP_se=$'\E[0m'        # End standout-Mode
export LESS_TERMCAP_md=$'\E[01;31m'    # Begin bold
export LESS_TERMCAP_mb=$'\E[01;31m'    # Begin blink
export LESS_TERMCAP_me=$'\E[0m'        # End

# gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


################################################################################
#
# Environment
#
################################################################################

GPG_TTY="$(tty)"
export GPG_TTY

export EDITOR="vi"
if [[ -f "/usr/bin/vim" ]]
then
  export EDITOR="vim"
  alias vi="vim"
fi
export VISUAL="$EDITOR"
export PAGER="less"
export LESS="-FiMnR"

# Path
for i in ~/.gem/ruby/*/bin ~/.local/bin
do
  [[ -d $i ]] && PATH="$PATH:$i"
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
    [[ -r "$file" ]] && . "$file"
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
alias burl="curl -k --proxy http://127.0.0.1:8080"
alias c="clear"
alias duchs='du -sch .[!.]* * |sort -h'
alias dstat-net='dstat --net --bits --noheaders 10'
alias dool-net='dool --net --bits --noheaders 10'
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
alias la='ls -hlisFA --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias ll='ls -hlisF --group-directories-first --time-style +%Y-%m-%d\ %H:%M:%S'
alias nmap-open='sudo nmap -v -d -n -Pn --open --reason -T4 --min-rate 100'
alias pomodoro='play -q -n synth sine 480 sine 620 remix 1-2 fade 0 0.5 delay 0.5 repeat 5 2>/dev/null'
alias pstop='ps -eo user,pid,ppid,pcpu,cpu,pmem,rss,cmd --sort -pcpu --width $COLUMNS | numfmt --header --to=iec --field 7 --padding 6 | cut -c 1-$COLUMNS | head -n $(($LINES-5))'
alias qrscan='maim -qs | zbarimg -q --raw - | tee >(xclip -selection clipboard)'
alias shit='sudo $(history -p \!\!)' 
alias slideshow="feh --fullscreen --auto-zoom --randomize --hide-pointer --slideshow-delay 3"
alias ssh-k='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'
alias strip-ansi="sed 's/\x1b\[[0-9;]*m//g'"

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

  [[ ! -f ~/.bashrc.local ]] && wget -q "$BASEURL/.bashrc.local" -O "$HOME/.bashrc.local" || true
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

imageshrink(){
  local quality="75"
  local size="2048x2048"
  local outputdir="./small"
  mkdir "$outputdir" || return 1
  for image in "$@"
  do
    echo "[*] Shrinking $image to $outputdir/$image ..."
    convert -resize "$size" -quality "$quality" "$image" "$outputdir/$image"
  done
}

infoman(){
  info "$1" | less
}

ip-pub(){
  local ipurl="https://motd.ch/ip.php"
  echo "Public IPv4 Address: $(curl -s -4 -L --write-out "\nLocal IPv4 Addres:   %{local_ip}" $ipurl)"
  echo "Public IPv6 Address: $(curl -s -6 -L --write-out "\nLocal IPv6 Addres:   %{local_ip}" $ipurl)"
}

ipapi(){
  curl -s -H "Accept: application/json" "https://api.ipapi.is/?q=$1"
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

mano(){
  # Open manpage of $1 and jump directly to the option $2
  man -P "less -p \"(^|, ) *$2\"" "$1"
}

mycd(){
  \cd "${1:-$HOME}"
  ls -lah
}

nettest(){
  echo "[*] IP address configuration:"
  \ip -color -brief addr list

  echo -e "\n[*] Route configuration:"
  \ip -color route

  echo -e "\n[*] Ping defaulg gateway:"
  ping "$(\ip route show default | cut -d ' ' -f 3)" -c 2 && echo "[*] Success" || echo "[*] FAIL!"

  echo -e "\n[*] Ping 1.1.1.1"
  ping -c 2 1.1.1.1 && echo "[*] Success" || echo "[*] FAIL!"

  echo -e "\n[*] Ping nameservers from resolv.conf"
  awk '/^nameserver/{ print $2 }' /etc/resolv.conf  | while read nameserver
  do
    ping -c 2 "$nameserver" && echo "[*] Success" || echo "[*] FAIL!"
  done

  echo -e "\n[*] Resolving via 9.9.9.9"
  dig +noall +answer switch.ch example.net @9.9.9.9 && echo "[*] Success"

  echo -e "\n[*] Resolving via OS"
  getent hosts example.net switch.ch

}

nmap-scripts-help(){
  nmap --script-help "*" | less
}

pa-output(){
  echo "Output devices:"
  pacmd list-sinks | grep -e device.description -e index:
  echo -n "Select: ";
  local number;
  read number;
  pacmd set-default-sink "$number"
}

pdf2png(){
  local input="$1"
  local output="${input%.pdf}.png"
  convert -density 150 "$input" -quality 100 -alpha remove "$output"

}
pdf2scan(){
  local input="$1"
  local output="${input%.pdf}_scan.pdf"
  convert -density 150 -format JPG -compress lzw -quality 5 "$input" -rotate 0.33 -attenuate 0.55 +noise Multiplicative -colorspace Gray "$output"
  exiftool -overwrite_original -all= "$output"
  exiftool -overwrite_original -xmptoolkit= -Producer="HP Scanning Suite for Windows" -Title="Scanned Document" -Author="HP CF1337A MFP" -Subject="" "$output"
}

pdfshrink(){
  for pdf in "$@"
  do
    local input="$pdf"
    local original="${input%.pdf}_original.pdf"
    local output="$input"
    mv "$input" "$original" && gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$original" || (echo "[*] Error while shrinking!" && return 1)
    du -h "$original" "$output"
  done
}

pretty_csv() {
  # Prettifies CSV input (https://www.stefaanlippens.net/pretty-csv.html)
  column -t -s, -n "$@" | less -F -S -X -K
}

proxy_on(){
  local host="$1"
  local port="${2:-8080}"
  local proto="${3-http}"
  local user="$4"
  local pass="$5"

  if [[ -n "$user" ]]
  then
      export http_proxy="$proto"://"$user":"$pass"@"$host":"$port"
  else
      export http_proxy="$proto"://"$host":"$port"
  fi

  export HTTP_PROXY="$http_proxy"
  export https_proxy="$http_proxy"
  export HTTPS_PROXY="$http_proxy"
  export ftp_proxy="$http_proxy"
  export FTP_PROXY="$http_proxy"
  export all_proxy="$http_proxy"
  export ALL_PROXY="$http_proxy"

  echo "Proxy is set to $http_proxy."
}

proxy_off(){
 for i in http_proxy HTTP_PROXY https_proxy HTTPS_PROXY ftp_proxy FTP_PROXY all_proxy ALL_PROXY
 do
   unset "$i"
 done

  echo "Proxy is disabled."
}

rgvim(){
  rg --color never -l $@ | xargs vim
}

securitytxt(){
  local domain="$1"
  local count="1"

  while true
  do
    host="$(cut -d . -f $count- <<< $domain)"
    if [[ -n "$host" ]]
    then
      for url in "https://$host/.well-known/security.txt" "https://$host/security.txt" "https://www.$host/.well-known/security.txt" "https://www.$host/security.txt"
      do
        echo -e "\033[0;34mLooking for security.txt on $url...\033[0m"
        if curl -sL "$url" | grep -qE "^Contact:"
        then
          echo -e "\n\033[0;32mFound security.txt on $url:\033[0m"
          curl -isL "$url"
          echo
        else
          echo "No security contact information found."
        fi
          echo
      done
      ((count ++))
    else
      break
    fi
  done
}

set-title(){
  # Set terminal title (https://askubuntu.com/questions/774532/how-to-change-terminal-title-in-ubuntu-16-04/774543#774543)
  if [[ -z "$ORIG" ]]; then
    ORIG="$PS1"
  fi
  TITLE="\[\e]2;$*\a\]"
  PS1="${ORIG}${TITLE}"
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

terminalcolors(){
  # Source: https://askubuntu.com/questions/27314/script-to-display-all-terminal-colors
  for x in 0 1 4 5 7 8
  do
    for i in {30..37}
    do
      for a in {40..47}
      do
        echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
      done
      echo
    done
  done
}

xcopy(){
  xclip -in -selection clipboard -f | xclip -in -selection primary -f | xclip -in -selection secondary
}


################################################################################
#
# Additional Initialization Files
#
################################################################################

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases
[[ -f ~/.bashrc.local ]] && . ~/.bashrc.local
