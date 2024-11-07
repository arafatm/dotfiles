#!/bin/bash
set -e

echo '########## Setting up dotfiles ########## '
DOTFILES=$HOME/dotfiles

if [[ $OSTYPE = 'darwin'* ]]; then ./setup.mac.sh; fi

echo '---------- Setting up ssh ---------- '
if grep -qi microsoft-standard-WSL2 /proc/version; then 
	echo 'Use 1Password auth'
	alias ssh='ssh.exe'
	alias ssh-add='ssh-add.exe'; 
	export GIT_SSH_COMMAND='ssh.exe'
else
	if [[ ! -f "$HOME/.ssh/github.ssh" ]]; then
		echo "github.ssh key not found"
		exit
	else
		echo 'keychain'
		eval `keychain --agents ssh --eval github.ssh`
	fi
fi

if [ -f /etc/lsb-release ]; then ./setup.ubuntu.sh; fi

echo "*** Setup dotfiles"

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

echo '---------- Default zsh ----------'

chsh -s $(which zsh)

echo '---------- Powerline on Windows ----------'
echo 'https://gist.github.com/stramel/658d702f3af8a86a6fe8b588720e0e23'
