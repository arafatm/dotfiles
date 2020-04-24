# cygwin vim is giving me errors. tired of debugging
# NOTE: make sre to set shell=cmd and set shellcmdflag=/c in vimrc

function wingvim() {
if [ -z "$1" ] ; then
  gvim.exe &
else
  gvim.exe $1 &
fi
}

if [ -f ~/.ghtoken ]; then source ~/.ghtoken; fi 

export DOTFILES=$HOME/dotfiles

function dotupdate() 
{
  pushd .

  cd $DOTFILES

  git pull

  echo "-------"
  if [ -z "$1" ] # Is parameter #1 zero length?
  then
    git diff
    echo "You must pass a commit message"
  else
    git add .
    git commit -m "$*"
    git push
    bash $DOTFILES/setup.sh
  fi
  popd
  source $HOME/.bashrc
}

#if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
#if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#  export TERM=xterm-256color
#  unset COLORTERM
#fi

if ! [ -x "$(command -v zsh)" ]; then
  source ~/.bash/colors
  source ~/.bash/gitprompt
  source ~/.bash/shellopts
  source ~/.bash/aliases
  source ~/.bash/aliasesdev
  source ~/.alias
fi

# added by travis gem
[ -f /Users/arafatm/.travis/travis.sh ] && source /Users/arafatm/.travis/travis.sh

complete -C /home/arafatm/apps/vault vault
