#!/bin/sh
set +x
echo '==> Start to deploy miniconda.'
echo ''
if [ -e ~/miniconda ]; then
  curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ./miniconda.sh
  bash ./miniconda.sh -b -p $(HOME)/miniconda > /dev/null 2>&1 || :
fi
grep -q "conda initialize" ~/.bashrc || _CONDA_PATH=$(HOME)/miniconda/etc/profile.d/conda.sh ./conda_bashrc.sh
eval "$(~/miniconda/bin/conda shell.bash hook)"
echo '==> restore conda base.'
conda env create -f=base.yml >/dev/null 2>&1