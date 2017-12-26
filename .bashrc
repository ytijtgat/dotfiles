FBLK="\[\033[30m\]" # foreground black
#FRED="\[\033[31m\]" # foreground red
FRED="\[\033[38;5;196m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
#FYEL="\[\033[33m\]" # foreground yellow
FYEL="\[\033[38;5;178m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
reset=$(tput sgr0)   # \e[0m

PS1="$HC$FYEL\A $FRED\h:$FYEL\W \$ \[$reset\]$RS"
COLUMNS=250

if [ "$TERM" == "xterm" ] || [ "$TERM" == "screen" ]; then
	# No it isn't, it's gnome-terminal
	export TERM=xterm-256color
fi

# Execute all specific commands for this server
if [ -f ~/.bashrc_specific ]; then
	source ~/.bashrc_specific;
fi

alias ll="ls -lvh --group-directories-first $LS_OPTIONS"

alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psm='/bin/ps --sort pgid,time,size,time,pcpu -o pid,pgid,state,user,start_time,time,size:9,pcpu,command'

# Print timestamp with history command
export HISTTIMEFORMAT="%d/%m/%y %T "

# Required for Vim
#if [ -f ~/.vim/plugged/gruvbox/gruvbox_256palette.sh ]; then
#	source ~/.vim/plugged/gruvbox/gruvbox_256palette.sh;
#fi

# Color for man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
shopt -s cmdhist
export HISTIGNORE="pwd:ls:history"


cd_func ()
 {
   local x2 the_new_dir adir index
   local -i cnt

   if [[ $1 ==  "--" ]]; then
     dirs -v
     return 0
   fi

   the_new_dir=$1
   [[ -z $1 ]] && the_new_dir=$HOME

   if [[ ${the_new_dir:0:1} == '-' ]]; then
     #
     # Extract dir N from dirs
     index=${the_new_dir:1}
     [[ -z $index ]] && index=1
     adir=$(dirs +$index)
     [[ -z $adir ]] && return 1
     the_new_dir=$adir
   fi

   #
   # '~' has to be substituted by ${HOME}
   [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

   #
   # Now change to the new dir and add to the top of the stack
   pushd "${the_new_dir}" > /dev/null
   [[ $? -ne 0 ]] && return 1
   the_new_dir=$(pwd)

   #
   # Trim down everything beyond 11th entry
   popd -n +11 2>/dev/null 1>/dev/null

   #
   # Remove any other occurence of this dir, skipping the top of the stack
   for ((cnt=1; cnt <= 10; cnt++)); do
     x2=$(dirs +${cnt} 2>/dev/null)
     [[ $? -ne 0 ]] && return 0
     [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
     if [[ "${x2}" == "${the_new_dir}" ]]; then
       popd -n +$cnt 2>/dev/null 1>/dev/null
       cnt=cnt-1
     fi
   done

   return 0
 }

 alias cd=cd_func

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        NAME=${1%.*}
        mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

function cdl_func ()
{
   cd $1;
   ll;
}
alias cdl=cdl_func


# Correct the directory colors
string2lscolors="grep '\w' | grep -v '^#' | sed 's/#.\+//' | perl -lane 'printf \"%s=%s:\", shift @F, join \";\", @F;'"
string2lscolors_cmd="cat ~/.ls_colors | $string2lscolors"
if [ -f ~/.ls_colors ]; then
   export LS_OPTIONS='--color=auto'
   export LS_COLORS=$(eval $string2lscolors_cmd)
fi

