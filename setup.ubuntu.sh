#!/bin/bash

set -e

if [ ! -f /etc/lsb-release ]; then
  echo "-----\nNot Ubuntu\n-----"
  exit
fi

sudo apt-get update
sudo apt-get dist-upgrade
sudo apt install tmux zsh fonts-firacode neovim zsh gpg curl \
  build-essential autoconf unzip libncurses5-dev libssl-dev \
  xsltproc fop libxml2-utils

rm -rf $HOME/.asdf && git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf

if [ ! -d "$HOME/code/dotfiles" ]; then
  echo '------------------------------------------------------------'
  echo '----- clone $HOME/code/dotfiles -----'
  echo '------------------------------------------------------------'
else
  cd $HOME/code/dotfiles && sh setup.dotfiles.sh 
fi
