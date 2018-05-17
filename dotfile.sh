#!/bin/bash
cd ~/
cp .bashrc bashrc_org
find dotfiles -maxdepth 1 -name ".[!.]?*" ! -name ".git" -print0 | xargs -0 -I % ln -s %
