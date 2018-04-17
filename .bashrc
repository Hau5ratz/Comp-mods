# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


##################
# Some settings
##################
set -o notify
set -o noclobber
set -o ignoreeof
#set -o nounset
#set -o xtrace          # useful for debuging

##################
# Enable options
##################
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.



function pre_prompt {
newPWD="${PWD}"
user="whoami"
host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
datenow=$(date "+%a, %d %b %y")
let promptsize=$(echo -n "┌($user@$host ddd., DD mmm YY)(${PWD})┐" \
                 | wc -c | tr -d " ")
let fillsize=${COLUMNS}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}─"
  let fillsize=${fillsize}-1
done
if [ "$fillsize" -lt "0" ]
then
    let cutt=3-${fillsize}
    newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
fi

}

PROMPT_COMMAND=pre_prompt

################################
# COLOURS!
################################
export BLACK="\[\e[0;30m\]"
export DARK_GRAY="\[\e[1;30m\]"
export RED="\[\e[0;31m\]"
export LIGHT_RED="\[\e[1;31m\]"
export GREEN="\[\e[0;32m\]"
export LIGHT_GREEN="\[\e[1;32m\]"
export BROWN="\[\e[0;33m\]"
export YELLOW="\[\e[1;33m\]"
export BLUE="\[\e[0;34m\]"
export LIGHT_BLUE="\[\e[1;34m\]"
export PURPLE="\[\e[0;35m\]"
export LIGHT_PURPLE="\[\e[1;35m\]"
export CYAN="\[\e[0;36m\]"
export LIGHT_CYAN="\[\e[1;36m\]"
export LIGHT_GRAY="\[\e[0;37m\]"
export WHITE="\[\e[1;37m\]"
export NO_COLOUR="\[\e[0m\]"

export BLACK='\e[0;30m'
export BLUE='\e[0;34m'
export GREEN='\e[0;32m'
export CYAN='\e[0;36m'
export RED='\e[0;31m'
export PURPLE='\e[0;35m'
export BROWN='\e[0;33m'
export LIGHTGRAY='\e[0;37m'
export DARKGRAY='\e[1;30m'
export LIGHTBLUE='\e[1;34m'
export LIGHTGREEN='\e[1;32m'
export LIGHTCYAN='\e[1;36m'
export LIGHTRED='\e[1;31m'
export LIGHTPURPLE='\e[1;35m'
export YELLOW='\e[1;33m'
export WHITE='\e[1;37m'
export NC='\e[0m'              # No Color

export black="\[\033[0;38;5;0m\]"
export red="\[\033[0;38;5;1m\]"
export orange="\[\033[0;38;5;130m\]"
export green="\[\033[0;38;5;2m\]"
export yellow="\[\033[0;38;5;3m\]"
export blue="\[\033[0;38;5;4m\]"
export bblue="\[\033[0;38;5;12m\]"
export magenta="\[\033[0;38;5;55m\]"
export cyan="\[\033[0;38;5;6m\]"
export white="\[\033[0;38;5;7m\]"
export coldblue="\[\033[0;38;5;33m\]"
export smoothblue="\[\033[0;38;5;111m\]"
export iceblue="\[\033[0;38;5;45m\]"
export turqoise="\[\033[0;38;5;50m\]"
export smoothgreen="\[\033[0;38;5;42m\]"

##################################################
# Color chart          #
##################################################

#txtblk='\e[0;30m' # Black - Regular
#txtred='\e[0;31m' # Red
#txtgrn='\e[0;32m' # Green
#txtylw='\e[0;33m' # Yellow
#txtblu='\e[0;34m' # Blue
#txtpur='\e[0;35m' # Purple
#txtcyn='\e[0;36m' # Cyan
#txtwht='\e[0;37m' # White
#bldblk='\e[1;30m' # Black - Bold
#bldred='\e[1;31m' # Red
#bldgrn='\e[1;32m' # Green
#bldylw='\e[1;33m' # Yellow
#bldblu='\e[1;34m' # Blue
#bldpur='\e[1;35m' # Purple
#bldcyn='\e[1;36m' # Cyan
#bldwht='\e[1;37m' # White
#unkblk='\e[4;30m' # Black - Underline
#undred='\e[4;31m' # Red
#undgrn='\e[4;32m' # Green
#undylw='\e[4;33m' # Yellow
#undblu='\e[4;34m' # Blue
#undpur='\e[4;35m' # Purple
#undcyn='\e[4;36m' # Cyan
#undwht='\e[4;37m' # White
#bakblk='\e[40m'   # Black - Background
#bakred='\e[41m'   # Red
#badgrn='\e[42m'   # Green
#bakylw='\e[43m'   # Yellow
#bakblu='\e[44m'   # Blue
#bakpur='\e[45m'   # Purple
#bakcyn='\e[46m'   # Cyan
#bakwht='\e[47m'   # White
#txtrst='\e[0m'    # Text Reset

case "$TERM" in
xterm)
    PS1="┌─($orange\u@\h \$(date \"+%a, %d %b %y\")$red)─\${fill}($orange\$newPWD\
$red)─┐\n└─($orange\$(date \"+%H:%M\") \$$red)─>$white "
    ;;
xterm-256color)
    PS1="┌─($orange\u@\h \$(date \"+%a, %d %b %y\")$red)─\${fill}($orange\$newPWD\
$red)─┐\n└─($orange\$(date \"+%H:%M\") \$$red)─>$white "
    ;;    
    *)
    PS1="┌─(\u@\h \$(date \"+%a, %d %b %y\"))─\${fill}(\$newPWD\
)─┐\n└─(\$(date \"+%H:%M\") \$)─> "
    ;;
esac

##################################################
# Bashrc greetings         #
##################################################

##### greeting
 # from Jonathan's .bashrc file (by ~71KR117)
 # get current hour (24 clock format i.e. 0-23)
 hour=$(date +"%H")
 # if it is midnight to midafternoon will say G'morning
 if [ $hour -ge 0 -a $hour -lt 12 ]
 then
   greet="Good Morning, $USER. Welcome back."
 # if it is midafternoon to evening ( before 6 pm) will say G'noon
 elif [ $hour -ge 12 -a $hour -lt 18 ]
 then
   greet="Good Afternoon, $USER. Welcome back."
 else # it is good evening till midnight
   greet="Good Evening, $USER. Welcome back."
 fi
 # display greeting
 clear
 echo $greet
######################################################
# WELCOME SCREEN
######################################################

echo -ne "today is, "; date
echo -e ; cal ;  
echo -ne ;
echo -ne "Sysinfo:";uptime ;echo ""
echo -ne ;

###### holiday greeting
 # from Jonathan's .bashrc file (by ~71KR117)
 # get current day (Month-Day Format)
 day=$(date +"%B%e")
 # get current year (for new years greeting)
 year=$(date +"%Y")
 # make sure the holiday greeting is displayed (if any)
 hol=1
 # if it is New Year's Day
 if [ "$day" = "January1" ]
 then
   holgreet="Happy New Years. Have a Happy $year."
 # if it is Groundhog Day
 elif [ "$day" = "February2" ]
 then
   holgreet="Have a Happy Groundhog Day."
 # if it is Valentine's Day
 elif [ "$day" = "February14" ]
 then
   holgreet="Have a Happy Valentine's Day."
 # if it is Independance Day
 elif [ "$day" = "July4" ]
 then
   holgreet="Have a Happy Forth of July."
 # if it is my birthday
 elif [ "$day" = "July19" ]
 then
   holgreet="Have a Happy Birthday."
 # if it is Halloween
 elif [ "$day" = "October31" ]
 then
   holgreet="Happy Halloween."
 # if it is Christmas Eve
 elif [ "$day" = "December24" ]
 then
   holgreet="Merry Christmas Eve."
 # if it is Christmas
 elif [ "$day" = "December25" ]
 then
   holgreet="Merry Christmas."
 # if it is New Year's Eve
 elif [ "$day" = "December31" ]
 then
   holgreet="Happy New Year's Eve."
 else
   hol=0
 fi
 # display holiday greeting
 if [ "$hol" = "1" ]
 then
 echo $holgreet
 elif [ "$hol" = "0" ]
 then
   randomvarthatsomehowimportant=0
 fi

##################################################
# history Setting        #
##################################################
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# leave some commands out of history log
export HISTIGNORE="&:??:[ ]*:clear:exit:logout:su"
export HISTFILESIZE=10000
export HISTSIZE=10000


##################################################################
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# enable personal aliases
if [ -f ~/.bash/.bash_aliases ]; then
    . ~/.bash/.bash_aliases
fi

# enable personal functions
if [ -f ~/.bash/.bash_functions ]; then
    . ~/.bash/.bash_functions
fi


# Aliases 

# User specific aliases and functions
#HK=''' Note following hotkeys:\n
# Command-Option-Esc : kill process\n
# Command-Tab : switch Applications\n
# Command-Shift- "[" | "]" : switch application tabs\n
# Command-M : Minimize active window\n
# Command-H : hide active window\n
# Command-Ctrl-F : Toggle maxi\n'''






# Custom Aliases and functions:
alias h="sed -n 300,400p ~/.bashrc"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias l="ls -Fhot"
alias c="clear"
alias reload="source ~/.bashrc"
alias redhat="ssh -l dc-user -p 2222 ech-10-157-142-19.mastercard.int"
alias house="ssh -l dc-user -p 4444 ech-10-157-132-51.mastercard.int"
alias rscanners="rsync -azP -e 'ssh -l dc-user -p 2222' ~/Desktop/Hau5ratz/Sup_py/wip/datadbmine/Scanners/ dc-user@ech-10-157-142-19.mastercard.int:/home/dc-user/wip/datadbmine/Scanners"
alias rshift="rsync -azP -e 'ssh -l dc-user -p 2222' ~/Desktop/Hau5ratz/Sup_py/wip/ dc-user@ech-10-157-142-19.mastercard.int:/home/dc-user/wip/"
alias rpull="rsync -azP -e 'ssh -l dc-user -p 2222' dc-user@ech-10-157-142-19.mastercard.int:/home/dc-user/wip/ ~/Desktop/Hau5ratz/Sup_py/wip "

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
