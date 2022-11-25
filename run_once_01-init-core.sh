#!/bin/bash

eval "$(~/$CONDA_PATH/bin/conda shell.bash hook)"
echo '==> setup bash'
echo ''
conda init bash
curl -fsSL "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark" -o ~/.dircolors

echo '==> setup fish'
echo ''
conda init fish
/usr/bin/env fish -c "curl -sL https://git.io/fisher | source && fisher update"
/usr/bin/env fish -c "abbr -a vi nvim"
/usr/bin/env fish -c "abbr -a vim nvim"
/usr/bin/env fish -c "abbr -a vie nvim -u ~/.config/nvim/essential.nvim"
/usr/bin/env fish -c "abbr -a rm trash-put"

echo '==> install direnv'
echo ''
source ~/.bash_profile
if ! type -P direnv; then
  curl -fsSL https://direnv.net/install.sh | bash
fi

echo '==> create ~/Applications dir'
echo ''
mkdir -p ~/Applications

echo '==> install neovim'
echo ''
if ! type nvim; then
  download_url=$(curl -sL https://api.github.com/repos/neovim/neovim/releases/latest|awk -F\" '/browser_download.*appimage"/ {print $4}')
  curl -o ~/Applications/nvim.appimage -L "$download_url"
  chmod +x ~/Applications/nvim.appimage 
  ln -s ~/Applications/nvim.appimage ~/.local/bin/nvim
fi

echo '==> install gnu password store'
echo ''
if ! type -P pass; then
  tmp=$(mktemp -d)
  cd $tmp
  curl -L https://git.zx2c4.com/password-store/snapshot/password-store-master.tar.xz | tar -x -J 
  cd password-store-master && make install PREFIX=$HOME/.local
  cd $HOME
  rm -rf $tmp
fi
