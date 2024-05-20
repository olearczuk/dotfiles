#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
rm $HOME/.zshrc
ln -s $PWD/home/zshrc $HOME/.zshrc

brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
