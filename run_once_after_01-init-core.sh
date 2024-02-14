#!/bin/bash

source ~/.bash_profile

eval "$(~/${CONDA_PATH:=miniconda3}/bin/conda shell.bash hook)"
echo '==> setup bash'
echo ''
conda init bash
curl -fsSL "https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark" -o ~/.dircolors

echo '==> install direnv'
echo ''
if ! type -P direnv; then
  curl -fsSL https://direnv.net/install.sh | bash
fi

echo '==> setup fish'
echo ''
conda init fish
/usr/bin/env fish -c "curl -sL https://git.io/fisher | source && fisher update"
/usr/bin/env fish -c "abbr -a vi nvim"
/usr/bin/env fish -c "abbr -a vim nvim"
/usr/bin/env fish -c "abbr -a vie nvim -u ~/.config/nvim/essential.nvim"
/usr/bin/env fish -c "abbr -a rm trash-put"

echo '==> create ~/Applications dir'
echo ''
mkdir -p ~/Applications

echo '==> install neovim'
echo ''
if ! type nvim; then
  repo="https://github.com/neovim/neovim/releases"
  latest_ver=$(curl -Ls "${repo}/latest" -o /dev/null -w %{url_effective} | grep -oP "[^/]*$")
  curl -o ~/Applications/nvim.appimage -L "${repo}/download/${latest_ver}/nvim.appimage"
  chmod u+x ~/Applications/nvim.appimage 
  ln -s ~/Applications/nvim.appimage ~/.local/bin/nvim
fi

echo '==> install git-credential-manager'
echo ''
if ! type -P git-credential-manager; then
  repo="https://github.com/git-ecosystem/git-credential-manager/releases"
  latest_ver=$(curl -Ls "${repo}/latest" -o /dev/null -w %{url_effective} | grep -oP "[^/]*$")
  curl -L "${repo}/download/${latest_ver}/gcm-linux_amd64.${latest_ver#v}.tar.gz" | tar -x -z -C ~/.local/bin
fi
