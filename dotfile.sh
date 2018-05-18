#!/bin/bash
cd ~/
cp .bashrc bashrc_org
find dotfiles -maxdepth 1 -name ".[!.]?*" ! -name ".git*" ! -name ".config" -print0 | xargs -0 -I % ln -snf %
[ -v "$XDG_CONFIG_HOME" ] && conighome=$XDG_CONFIG_HOME || conighome="~/.config"
cd $conighome  
find ~/dotfiles/.config  -maxdepth 1 -type d -name "[!.]*" -print0 | xargs -0 -I % ln -snf %
