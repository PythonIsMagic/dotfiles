# ++ My Aliases
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoredups


# ##################################################
# Directory navigation 
# ##################################################
alias ~='cd ~'
alias cd-='cd -'  
alias ..='cd ..'
alias cd~='cd ~'    
alias cd..='cd ..'  
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias bak='cd ~/Documents/bak'
alias dev='cd ~/Documents/dev'
alias dl='cd ~/Downloads'
alias doc='cd ~/Documents/doc'
alias dot='cd ~/Documents/dotfiles'
alias logs='cd ~/Documents/logs'
alias rip='cd ~/Documents/scripts' 
alias tmp='cd ~/Documents/tmp'
alias wi='cd ~/Documents/wiki/EriksWiki/data' 
alias trash='cd ~/.local/share/Trash'
alias todo='vim ~/Documents/dotfiles/todo/todolist.txt'
alias junk='cd ~/Documents/junkdrawer'

alias vid='cd /media/zeus/multimedia/Video'
alias music='cd /media/zeus/multimedia/Music'
alias pony='cd /media/zeus/multimedia/PonyShow'
alias iso='cd /media/zeus/multimedia/iso'
alias games='cd /media/zeus/multimedia/Games'
alias pony='cd /media/zeus/multimedia/PonyShow'

alias xc='xclip -selection c'         # Move something to the clipboard  

# alias python='python3'
# alias py='cd ~/Documents/dev/python'
alias py='clear; ipython'
alias py3='clear; ipython3'
# alias py3='clear; ipython3'
# alias pydoc='python /usr/lib/python3.4/pydoc.py -b'

alias rs='python manage.py runserver'

alias rmtrash='rm -rfv ~/.local/share/Trash/*' # Remove trash
alias rebash='source /etc/bash.bashrc' # Re-Source the bashrc file.

# Git aliases

alias gs='git status'
alias gl='git log --oneline -10'
alias lg='git log --graph --decorate --oneline --abbrev-commit --all'
alias gaa='git add --all'

# ##################################################
# OTHER FUNCTIONS
# ##################################################
function l { 
    ls -l --almost-all --human-readable --no-group --escape --time-style='+%b %d %Y %H:%M' "$@"
}

function tree {       # Generates a tree view from the current directory
    pwd; ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/';
}

function nkill {      # Kill a process by name
    if [ -z "$1" ]; then echo -e "Usage: pskill [processName]";
    else pgrep "$1" | awk "{print kill -9 $1}";
        #ps -au $USER | grep -i "$1" |awk {print kill -9 "$1"}
    fi
}

function exportwiki { # Exports the wiki to HTML
	~/Documents/scripts/handle_wikidpad.sh
	~/Documents/scripts/exportwiki.sh
}

function replace {    # Replace spaces in file/dir names with _.
	~/Documents/scripts/replace_filename_spaces.sh 
}

function wim {        # Run the Wiki Manager Script
	~/Documents/scripts/wikidpad_manager.sh
}


function go {           # Gnome-open to get almost any resource
	gnome-open "$@"; 
}

# Enable Shellcheck
export PATH="$HOME/.cabal/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Add my scripts directory
# export PATH="$PATH:$HOME/Documents/scripts"

export NVM_DIR="/home/lunatunez/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"

# For easy access to these python modules
export PYTHONPATH="$HOME/Documents/dev/scrape_ponies"

# Add the webdrivers
export PATH="$PATH:$HOME/webdrivers"
# source /usr/local/bin/activate.sh
