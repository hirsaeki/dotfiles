#!/bin/sh
echo '==> Start to deploy miniconda.'
echo ''
if [ ! -e ~/miniconda/bin/conda ]; then
  curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ./miniconda.sh
  bash ./miniconda.sh -b -p ${HOME}/miniconda > /dev/null 2>&1 || :
fi
echo '==> create bashrc from template'
echo ''
cp bashrc.tpl .bashrc
echo '==> conda initialize'
echo ''
grep -q "conda initialize" ~/.bashrc || _CONDA_ROOT=${HOME}/miniconda ./conda_bashrc.sh
eval "$(~/miniconda/bin/conda shell.bash hook)"
echo '==> restore conda base.'
conda env update -f=base.yml
make init
make deploy
