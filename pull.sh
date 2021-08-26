#!/bin/sh
echo 'pull dotfile repo'
if [ ! -e ~/.dotfiles ]; then
  mkdir -p ~/.dotfiles
  curl -L https://github.com/hirsaeki/dotfile/archive/conda.tar.gz | tar -x -C ~/.dotfiles --split-component 1
fi
cd ~/.dotfiles
echo 'Initialize dotfile'
./initialize.sh
