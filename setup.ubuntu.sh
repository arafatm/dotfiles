#!/bin/bash

set -e

DOTFILES=$HOME/code/dotfiles

if [ ! -f /etc/lsb-release ]; then
	echo '-----\nNot Ubuntu\n-----'
	exit
fi

echo '---------- Setting up Ubuntu ---------- '
sudo apt-get update -y
sudo apt-get dist-upgrade -y
sudo apt install tmux zsh fonts-firacode neovim zsh gpg curl \
  build-essential autoconf unzip libncurses5-dev libssl-dev \
  xsltproc fop libxml2-utils

echo '---------- Setting up asdf ---------- '
rm -rf $HOME/.asdf && git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf

if [[ $(echo $HOST) == "kodi" ]]; then
  echo '############################################################'
  echo 'ssh-copy-id -i <ssh-file> kodi@hostname' 
  echo 'cat GH_TOKEN={GH Kodi Token} > $HOME/.env'
  echo '0 0 * * * docker image prune'
  echo '0 * * * * echo "##### $(date) $(HOME/duck.sh) #####" >> $LOG 2>&1'
fi

echo '############################################################'
echo '0 * * * * $HOME/bin/bkps.git.cron >> $LOG 2>&1'
echo '############################################################'
