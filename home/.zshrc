# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"

ZSH_TMUX_AUTOQUIT=false
zstyle :omz:plugins:keychain agents gpg,ssh
#zstyle :omz:plugins:keychain identities ssh.github

plugins=( asdf keychain docker )
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/
source $ZSH/oh-my-zsh.sh

# my paths
appPaths=( $HOME/apps $HOME/bin /usr/local/bin)
for d in ${appPaths[@]}; do export PATH=$d:$PATH; done

# Shell options
export TERM=xterm-256color
set -o vi
autoload -U +X bashcompinit && bashcompinit

# Aliases
if [[ -f $HOME/.alias ]];      then source $HOME/.alias; fi
if [[ -f $HOME/.zmisc ]];      then source $HOME/.zmisc; fi
if [[ -f $HOME/.alias.work ]]; then source $HOME/.alias.work; fi

# Dev stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi       # rbenv
if [[ -f  "$HOME/.asdf/asdf.sh" ]]; then source "$HOME/.asdf/asdf.sh"; else echo "asdf not installed"; fi; 

find $HOME/.ssh -type f -name "*.ssh" -exec bash -c 'eval `keychain --agents ssh -q --eval $0`' {} \;

echo -e "\n\e[41m SPEAK LESS, BUT NOTICE EVERYTHING. \e[0m"
echo -e "\n\e[41m The secret of getting ahead is getting started. — Mark Twain, from his book “The Innocents Abroad. \e[0m"
