#!/bin/bash

ln -s $PWD/nvim $HOME/.config/nvim
ln -s $PWD/home/gitconfig $HOME/.gitconfig

sh -c "$(curl -fsSL https://install.ohmyz.sh)"
mv $HOME/.zshrc $HOME/.oh-my-zshrc
ln -s $PWD/home/zshrc $HOME/.zshrc
