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
	echo "homebrew already installed"
fi

export PATH=$HOME/homebrew/bin:$PATH

echo "****** ***** ***** **** Installing brews"
brew install zsh git tmux neovim htop tldr zsh-syntax-highlighting 

echo "****** ***** ***** **** installing ohmyzsh"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

chsh -s $(which zsh)

echo "****** ***** ***** **** installing casks"
brew cask install iterm2 rectangle google-chrome brave-browser oracle-jdk 

brew tap homebrew/cask-fonts && brew cask install font-fira-code font-fira-mono-for-powerline

if [ ! -d "$HOME/dotfiles" ]; then
	git clone git@github.com:arafatm/dotfiles && \
		cd dotfiles && sh setup.dotfiles.sh
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
echo "Brave disable password save: Settings -> Advanced > Autofill"
echo ""
echo "Brave install extensions: 1passwordx"
echo ""
echo "iterm2 set font to Fira Mono for Powerline"


