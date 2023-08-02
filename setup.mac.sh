#!/bin/bash

set -e

if [[ $OSTYPE != 'darwin'* ]]; then
  echo "Not a Mac"
  exit
fi

cd $HOME

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
  gnu-sed \
  htop \
  keychain \
  neovim \
  pyenv \
  tldr \
  tmux \
  zsh \
  zsh-syntax-highlighting

echo "****** ***** ***** **** installing casks"
brew install --cask \
  iterm2 \
  honer \
  rectangle \
  steermouse \
  firefox \
  oracle-jdk \
  slack \
  visual-studio-code \
  1password

brew tap homebrew/cask-fonts && brew install --cask font-fira-code font-fira-mono-for-powerline
sudo apt install fonts-firacode
if [ ! -d "$HOME/dotfiles" ]; then
  git clone git@github.com:arafatm/dotfiles && \
    cd dotfiles && sh setup.dotfiles.sh && \
fi

# VSCode
if [ -d "$HOME/dotfiles/vscode" ]; then
  vscode="/Library/Application\ Support/Code/User"
  if [ -d "$vscode" ]; then 
    if [ -f "$vscode/settings.json" ]; then rm -f  $vscode/settings.json; fi
    if [ -f "$vscode/keybindings.json" ]; then rm -f  $vscode/keybindings.json; fi
    if [ -d "$vscode/snippets" ]; then rm -rf $vscode/snippets; fi
    ln -s $HOME/dotfiles/vscode/settings.json $vscode/settings.json
    ln -s $HOME/dotfiles/vscode/keybindings.json $vscode/keybindings.json
    ln -s $HOME/dotfiles/vscode/snippets $vscode/snippets
    echo "- Created VSCode"
    echo "  - VSCode extensions setup"
    echo "  - code --list-extensions > $DOTFILES/vscode/extensions.txt"
    echo "  - cat extensions.txt | xargs -L 1 code --install-extension"
  else
    echo "*** VSCode not set up"
  fi
fi

cd $HOME

echo "****** ***** ***** **** DONE"
echo "Customize Caps/Esc in Preferences -> Keyboard -> Customize Modifier Keys"
echo "##### https://help.github.com/en/enterprise/2.17/user/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent"
echo "https://blog.testdouble.com/posts/2020-04-07-favorite-things/"
echo "https://steemit.com/code/@demwunz/how-to-get-a-customised-and-pretty-zsh-terminal-on-mac-osx"
echo "iterm2 set font to Fira Mono for Powerline"

