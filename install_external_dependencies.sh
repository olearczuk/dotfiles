#!/bin/bash

sh -c "$(curl -fsSL https://install.ohmyz.sh)"
mv $HOME/.zshrc $HOME/.oh-my-zshrc
ln -s $PWD/home/zshrc $HOME/.zshrc

brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
