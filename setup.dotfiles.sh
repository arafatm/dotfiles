#!/bin/bash
set -e

DOTFILES=$HOME/dotfiles

echo "*** git config email"
git config --global user.email "19172+arafatm@users.noreply.github.com"

if ! [ -x "$(command -v zsh)" ]; then
  echo "*** oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "*** zsh not installed"
fi

echo "*** Setup dotfiles"

for f in `ls -A $DOTFILES/home`; do
  rm -rf $HOME/$f
  ln -s $DOTFILES/home/$f $HOME/
done
echo '- installed dotfiles'

if [ ! -d "$HOME/tmp" ]; then
  mkdir $HOME/tmp
fi
echo '- created ~/tmp'

# NeoVim
for f in `ls -A $DOTFILES/nvim`; do
  rm -rf $HOME/.config/nvim
  mkdir -p $HOME/.config
  ln -s $DOTFILES/nvim $HOME/.config/nvim
done
echo '- created neovim'

# gVim doesn't like symlinks :shrug:
# cygwin vim startup is stupid slow on my system.
# so...
if [ "$(expr substr $(uname -s) 1 13)" == "CYGWIN_NT-6.1" ]; then
  rm -rf $HOME/.gvimrc $HOME/.vimrc $HOME/.vim
  cp -rf $DOTFILES/home/.gvimrc $HOME/.gvimrc
  cp -rf $DOTFILES/home/.vimrc $HOME/.vimrc
  cp -rf $DOTFILES/home/.vim $HOME/.vim
fi
echo '- created stoopid windows'

unalias -a
echo '- unalias -a'

if ! [ -f "$HOME/.oh-my-zsh" ]; then
  source $HOME/.bashrc
  echo '- source bashrc'
fi

echo "*** DONE Setup dotfiles"

