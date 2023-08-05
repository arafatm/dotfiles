#!/bin/bash

set -e

DOTFILES=$HOME/code/dotfiles

if [ ! -f /etc/lsb-release ]; then
  echo '-----\nNot Ubuntu\n-----'
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
  cd $DOTFILES && sh setup.dotfiles.sh 
fi

if [[ $(HOST) == "kodi" ]]; then
  echo '############################################################'
  echo 'ssh-copy-id -i <ssh-file> kodi@hostname' 
  echo 'cat GH_TOKEN={GH Kodi Token} > $HOME/.env'
  echo '0 0 * * * docker image prune'
  echo '0 * * * * echo "##### $(date) $(HOME/duck.sh) #####" >> $LOG 2>&1'
fi

echo '############################################################'
echo '0 * * * * $HOME/bin/bkps.git.cron >> $LOG 2>&1'
echo '############################################################'
