#!/bin/bash

pushd $HOME/private && git pull
pushd $HOME/notes && git pull
pushd $HOME/dotfiles && git pull
popd; popd; popd
