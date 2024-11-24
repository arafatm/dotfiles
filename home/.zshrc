#export LANG=en_US.UTF-8
#export LC_CTYPE=en_US.UTF-8

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="blinks"
plugins=( asdf docker globalias )
source $ZSH/oh-my-zsh.sh
ZSH_TMUX_AUTOQUIT=false

# my paths
PATH="$HOME/apps:$PATH"
PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH" # pip3
PATH="/usr/local/bin:$PATH"
PATH="/snap/bin:$PATH"

# Shell options
export TERM=xterm-256color
set -o vi
autoload -U +X bashcompinit && bashcompinit

# Aliases
if [[ -f $HOME/.env ]];        then source $HOME/.env; fi
if [[ -f $HOME/.alias ]];      then source $HOME/.alias; fi
if [[ -f $HOME/.alias.priv ]]; then source $HOME/.alias.priv; fi
if [[ -f $HOME/.alias.work ]]; then source $HOME/.alias.work; fi

# Dev stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi       # rbenv
if [[ -f  "$HOME/.asdf/asdf.sh" ]]; then source "$HOME/.asdf/asdf.sh"; else echo "asdf not installed"; fi; 
export FLYCTL_INSTALL="/home/arafatm/.fly"; PATH="$HOME/.fly/bin:$PATH"

find $HOME/.ssh -type f -name "*.ssh" -exec bash -c 'eval `keychain --agents ssh -q --eval $0`' {} \;

echo -e "\n\e[41m SPEAK LESS, BUT NOTICE EVERYTHING. \e[0m"
echo -e "\n\e[41m The secret of getting ahead is getting started. — Mark Twain, from his book “The Innocents Abroad. \e[0m"

# add Pulumi to the PATH
export PATH=$PATH:/home/arafatm/.pulumi/bin
