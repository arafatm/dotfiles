#!/bin/bash
set -e

echo '########## Setting up dotfiles ########## '
DOTFILES=$HOME/code/dotfiles

echo "*** Setup dotfiles"

echo '---------- Setting up ssh ---------- '
if [[ ! -f "$HOME/.ssh/github.ssh" ]]; then
  echo "github.ssh key not found"
else
  eval `keychain --agents ssh --eval github.ssh`
fi

echo '---------- Setting up oh-my-zsh ----------'
if [[ ! -d $HOME/.oh-my-zsh ]]; then 
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh
else 
  cd $HOME/.oh-my-zsh && git pull --depth 1
fi
echo "- installed ohmyzsh"

echo '---------- Setting up dotfiles ----------'
for f in `ls -A $DOTFILES/home`; do
  rm -rf $HOME/$f
  ln -s $DOTFILES/home/$f $HOME/
done
echo '- installed dotfiles'

if [ ! -d "$HOME/tmp" ]; then
  mkdir $HOME/tmp
fi
echo '- created ~/tmp'

echo '---------- Setting up NeoVim ----------'
rm -rf $HOME/.config/nvim
mkdir -p $HOME/.config/nvim
for f in `ls -A $DOTFILES/nvim`; do
  ln -s $DOTFILES/nvim/$f $HOME/.config/nvim/$f
done
echo '- created neovim'

#echo '---------- Switch to zsh ----------'
#if [ $(echo $SHELL) != "/bin/zsh" ]; then chsh -s $(which zsh); fi
#echo "shell should be zsh"

#echo '---------- unalias and source .zshrc ----------'
#unalias -a; source $HOME/.zshrc

echo '---------- DONE Setup dotfiles ----------'

echo '$ chsh -s zsh'
