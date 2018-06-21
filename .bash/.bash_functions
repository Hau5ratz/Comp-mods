function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

function myps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { myps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(myps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
    for fs ; do

        if [ ! -d $fs ]
        then
          echo -e $fs" :No such file or directory" ; continue
        fi

        local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
        local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
        local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
        local out="["
        for ((j=0;j<20;j++)); do
            if [ ${j} -lt ${nbstars} ]; then
               out=$out"*"
            else
               out=$out"-"
            fi
        done
        out=${info[2]}" "$out"] ("$free" free on "$fs")"
        echo -e $out
    done
}

function myip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}

findgrep () {           # find | grep
        if [ $# -eq 0 ]; then
                echo "findgrep: No arguments entered."; return 1
        else
                # "{.[a-zA-Z],}*" instead of "." makes the output cleaner
                find {.[a-zA-Z],}* -type f | xargs grep -n $* /dev/null \
                                2> /dev/null
        fi
}

function ff() { find . -name '*'$1'*' ; }                 # find a file
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }  # find a file and run $2 on it 
function fstr() # find a string in a set of files
{
    if [ "$#" -gt 2 ]; then
        echo "Usage: fstr \"pattern\" [files] "
        return;
    fi
    SMSO=$(tput smso)
    RMSO=$(tput rmso)
    find . -type f -name "${2:-*}" -print | xargs grep -sin "$1" | \
sed "s/$1/$SMSO$1$RMSO/gI"
}

function cuttail() # cut last n lines in file, 10 by default
{
    nlines=${2:-10}
    sed -n -e :a -e "1,${nlines}!{P;N;D;};N;ba" $1
}

authme() {
  [[ -z "$1" ]] && printf "Usage: authme <ssh_host> [<pub_key>]\n" && return 10

  local host="$1"
  shift
  if [[ -z "$1" ]] ; then
    local key="${HOME}/.ssh/id_dsa.pub"
  else
    local key="$1"
  fi
  shift

  [[ ! -f "$key" ]] && echo "SSH key: $key does not exist." && return 11

  if echo "$host" | egrep -q ':' ; then
    local ssh_cmd="$(echo $host | awk -F':' '{print \"ssh -p \" $2 \" \" $1}')"
  else
    local ssh_cmd="ssh $host"
  fi

  $ssh_cmd '(if [ ! -d "${HOME}/.ssh" ]; then \
    mkdir -m 0700 -p ${HOME}/.ssh; fi; \
    cat - >> .ssh/authorized_keys)' < $key
}


##
# Returns the remote user's public SSH key on STDOUT. The host can optionally
# contain the username (like `jdoe@ssh.example.com') and a non-standard port
# number (like `ssh.example.com:666').
#
# @param [String] remote ssh host in for form of [<user>@]host[:<port>]
# @param [String] remote public key, using id_dsa.pub by default
mysshkey() {
  [[ -z "$1" ]] && printf "Usage: mysshkey <ssh_host> [<pub_key>]\n" && return 10

  local host="$1"
  shift
  if [[ -z "$1" ]] ; then
    local key="id_dsa.pub"
  else
    local key="$1"
  fi
  shift

  if echo "$host" | egrep -q ':' ; then
    local ssh_cmd="$(echo $host | awk -F':' '{print \"ssh -p \" $2 \" \" $1}')"
  else
    local ssh_cmd="ssh $host"
  fi

  $ssh_cmd "(cat .ssh/$key)"
}
##
# These are my homebrewed file creation and formatting functions 
##
ss() {
  filename=$1'.sh'
  echo '#!/bin/bash' > $filename 
  subl $filename
  }
pys() {
  filename=$1'.py'
  printf '#!/usr/bin/python3.6\n__author__ = "Nicholas Rademaker"\n__copyright__ = "Me I will fight you"\n__credits__ = ["Nicholas Rademaker"]\n__license__ = "None"\n__version__ = "0"\n__maintainer__ = "Nicholas Rademaker"\n__email__ = "nrademaker@gm.slc.edu"\n__status__ = "Developing"' > $filename 
  subl $filename
  }
fpath() {
  path=$@
  echo
  echo "Your formated path is the following:"
  echo "${path// /\\ }"  
  }
