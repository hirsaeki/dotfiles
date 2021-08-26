#!/bin/sh
echo 'pull dotfile repo'
if [ ! -e ~/.dotfile ]; then
  mkdir -p ~/.dotfile
  curl -OL https://github.com/hirsaeki/dotfile/archive/conda.tar.gz | tar -x -C ~/.dotfile --split-component 1
fi
cd ~/.dotfile
echo 'Initialize dotfile'
./initialize.sh
