#!/bin/bash

set -e

cd $HOME

if [ ! -f "$HOME/.ssh/id_rsa" ]; then
        echo "##### https://help.github.com/en/enterprise/2.17/user/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
	exit
fi

if [ ! -d "$HOME/homebrew" ]; then
	echo "installing homebrew"
	mkdir $HOME/homebrew && \
		curl -L https://github.com/Homebrew/brew/tarball/master \
		| tar xz --strip 1 -C homebrew
else
  brew update
fi

export PATH=$HOME/homebrew/bin:$PATH

echo "****** ***** ***** **** Installing brews"
brew install \
  coreutils \
  ctags \
  git \
  htop \
  neovim \
  pyenv \
  tldr \
  tmux \
  zsh \
  zsh-syntax-highlighting


echo "****** ***** ***** **** installing ohmyzsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ $(echo $SHELL) != "/bin/zsh" ]]; then; chsh -s $(which zsh); fi

echo "****** ***** ***** **** installing casks"
brew cask install \
  iterm2 \
  honer \
  rectangle \
  google-chrome \
  firefox \
  oracle-jdk \
  spotify \
  slack

brew tap homebrew/cask-fonts && brew cask install font-fira-code font-fira-mono-for-powerline

if [ ! -d "$HOME/dotfiles" ]; then
  git clone git@github.com:arafatm/dotfiles && \
    cd dotfiles && sh setup.dotfiles.sh && \
fi

if [ -d "$HOME/dotfiles/vscode" ]; then
  ln -s $HOME/dotfiles/vscode/settings.json $HOME/Library/Application\ Support/Code/User/settings.json
  ln -s $HOME/dotfiles/vscode/keybindings.json $HOME/Library/Application\ Support/Code/User/keybindings.json
  ln -s $HOME/dotfiles/vscode/snippets $HOME/Library/Application\ Support/Code/User/snippets
fi

cd $HOME

echo "****** ***** ***** **** DONE"
echo ""
echo "https://blog.testdouble.com/posts/2020-04-07-favorite-things/"
echo ""
echo "https://steemit.com/code/@demwunz/how-to-get-a-customised-and-pretty-zsh-terminal-on-mac-osx"
echo ""
echo "Don't forget to manually install 1password"
echo ""
echo "iterm2 set font to Fira Mono for Powerline"
