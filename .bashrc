# ++ My Aliases
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoredups


# Navigation aliases
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
alias dl='cd ~/Downloads'

# Python alises
alias py='clear; ipython'
alias py3='clear; ipython3'
alias pydoc='python3 /usr/lib/python3.4/pydoc.py -b'
alias rs='python manage.py runserver'

# Git aliases
alias gs='git status'
alias gl='git log --oneline -10'
alias lg='git log --graph --decorate --oneline --abbrev-commit --all'
alias gaa='git add --all'

# Taking out the trash on Linux Mint
alias rmtrash='rm -rfv ~/.local/share/Trash/*' 

alias rebash='source /etc/bash.bashrc' # Re-Source the bashrc file.
alias xc='xclip -selection c'         # Move something to the clipboard  

# ##################################################
# FUNCTIONS
# ##################################################
# Super fancy ls with all bells and whistles
function l { 
    ls -l --almost-all --human-readable --no-group --escape --time-style='+%b %d %Y %H:%M' "$@"
}

function tree {       # Generates a tree view from the current directory
    pwd; ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/';
}

function nkill {      # Kill a process by name
    if [ -z "$1" ]; then 
		echo -e "Usage: pskill [processName]";
    else 
		pgrep "$1" | awk "{print kill -9 $1}";
    fi
}

function go {           # Gnome-open to get almost any resource
	gnome-open "$@"; 
}

# Add the webdrivers
export PATH="$PATH:$HOME/webdrivers"
# source /usr/local/bin/activate.sh

# Enable git auto completion
if [ -f ~/.git-completion.bash ]; then
	# shellcheck source=/dev/null
	source ~/.git-completion.bash
	#PS1='\W$(__git_ps1 "(%s)") > '  # switches to normal dir when out of git dir.
fi

# This is to enable using Control-S in the .vimrc file.
stty -ixon

# See http://aaroncrane.co.uk/2009/03/git_branch_prompt/ for info on the prompt
export TERM=xterm-256color

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
    complete -o default -o nospace -F _git g;
fi;

function find_git_branch {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch=" ${head#*/*/}"
            elif [[ $head != '' ]]; then
                git_branch=' (detached)'
            else
                git_branch=' (unknown)'
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

green=$'\e[1;32m'
magenta=$'\e[1;35m'
# normal_colours=$'\e[m'

#PS1="\[$green\]\u@\h:\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "

# Git prompt that works
# PS1="\[$green\]\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "
# PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"

PS1="[\[\033[32m\]\w]\[\033[0m\]\[$green\]\[$magenta\]\$git_branch\[$green\]\\n\[\033[1;36m\]\[\033[1;33m\]-> $ \[\033[0m\]"

# Source aliases
if [ -f ~/.custom_aliases ]; then
	# shellcheck source=/dev/null
	. ~/.custom_aliases
fi

# Source functions
if [ -f ~/.custom_functions ]; then
	# shellcheck source=/dev/null
	. ~/.custom_functions
fi
