#!/bin/bash
eval "$(~/${CONDA_PATH:=miniconda3}/bin/conda shell.bash hook)"

echo '==> install tfenv'
echo ''
if ! type -P tfenv; then
  git clone https://github.com/tfutils/tfenv.git ~/.local/share/tfenv 2> /dev/null
  ln -sfn ~/.local/share/tfenv/bin/* ~/.local/bin
fi

echo '==> install tgenv'
echo ''
if ! type -P tgenv; then
  git clone https://github.com/cunymatthieu/tgenv.git ~/.local/share/tgenv 2> /dev/null
  ln -sfn ~/.local/share/tgenv/bin/* ~/.local/bin
fi

echo '==> install terraform-ls.'
echo ''
if ! type -P terraform-ls; then
  ls_ver=$(curl -sL https://releases.hashicorp.com/terraform-ls|grep href=\"/terraform|head -n 1|awk -F/ '{print $3}')
  curl -sL https://releases.hashicorp.com/terraform-ls/$ls_ver/terraform-ls_${ls_ver}_linux_amd64.zip -o terraform-ls.zip 2> /dev/null
  unzip -u terraform-ls.zip && mv terraform-ls ~/.local/bin && rm terraform-ls.zip
fi

echo '==> install govc.'
echo ''
if ! type -P govc; then
  curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(uname -s)_$(uname -m).tar.gz" | tar -C ~/.local/bin -xvzf - govc
fi
