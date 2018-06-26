# Directory navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# command colorful
# May not work with work computer
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#-------------------------------------------------------------
## The 'ls' family (this assumes you use a recent GNU ls).
##-------------------------------------------------------------
## Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

## The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


alias h="history | grep"

alias rm='rm -vi'
alias cp='cp -vi'
alias mv='mv -vi'

alias df='df -h'

# yum
alias yumi='yum install'
alias yumr='yum remove'
alias yumu='yum update'
alias yumg='yum upgrade'

# chmod
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

#Use human-readable filesizes
alias du="du -h"
alias df="df -h"

alias clean='rm -f "#"* "."*~ *~ *.bak *.dvi *.aux *.log'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'


alias h="sed -n 300,400p ~/.bashrc"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias l="ls -Fhot"
alias c="clear"
alias reload="source ~/.bashrc"
alias wiggle="python2.7 ~/.python/wiggle.py"
#-------------------------------------------------------------
## These are for ssh in mc (this assumes you are my home terminal).
##-------------------------------------------------------------
#alias redhat="ssh -l dc-user -p 2222 ech-10-157-142-19.mastercard.int"
#alias house="ssh -l dc-user -p 4444 ech-10-157-132-51.mastercard.int"
#alias rscanners="rsync -azP -e 'ssh -l dc-user -p 2222' ~/Desktop/Hau5ratz/Sup_py/wip/datadbmine/Scanners/ dc-user@ech-10-157-142-19.mastercard.int:/home/dc-user/wip/datadbmine/Scanners"
#alias rshift="rsync -azP -e 'ssh -l dc-user -p 2222' ~/Desktop/Hau5ratz/Sup_py/wip/ dc-user@ech-10-157-142-19.mastercard.int:/home/dc-user/wip/"
#alias rpull="rsync -azP -e 'ssh -l dc-user -p 2222' dc-user@ech-10-157-142-19.mastercard.int:/home/dc-user/wip/ ~/Desktop/Hau5ratz/Sup_py/wip "
