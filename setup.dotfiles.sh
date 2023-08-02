#!/bin/bash
set -e

echo "***** ***** Setup dotfiles***** ***** "
DOTFILES=$HOME/code/dotfiles

echo "*** Setup dotfiles"

echo "## Setting up ssh"
if [[ ! -f "$HOME/.ssh/ssh.github" ]]; then
  echo "ssh keys not found"
  exit
else
  eval `keychain --agents ssh --eval ssh.github`
fi

echo "## Setting up oh-my-zsh"
rm -rf $HOME/.oh-my-zsh && \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --keep-zshrc --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
echo "- installed ohmyzsh"

echo "## Setting up dotfiles"
for f in `ls -A $DOTFILES/home`; do
  rm -rf $HOME/$f
  ln -s $DOTFILES/home/$f $HOME/
done
echo '- installed dotfiles'

if [ ! -d "$HOME/tmp" ]; then
  mkdir $HOME/tmp
fi
echo '- created ~/tmp'

echo "## Setting up NeoVim"
rm -rf $HOME/.config/nvim
mkdir -p $HOME/.config/nvim
for f in `ls -A $DOTFILES/nvim`; do
  ln -s $DOTFILES/nvim/$f $HOME/.config/nvim/$f
done
echo '- created neovim'

echo "## Switch to zsh"
if [ $(echo $SHELL) != "/bin/zsh" ]; then chsh -s $(which zsh); fi
echo "shell should be zsh"

echo "## unalias and source .zshrc"
unalias -a; source $HOME/.zshrc

echo "*** DONE Setup dotfiles ***"

