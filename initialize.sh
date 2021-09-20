#!/bin/sh
echo '==> Start to deploy miniconda.'
echo ''
if ! type "conda" > /dev/null 2>&1 ;then
  curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ./miniconda.sh
  bash ./miniconda.sh -b -p ${HOME}/miniconda
fi
echo '==> create bashrc from template'
echo ''
cp _bashrc .bashrc
echo '==> conda initialize'
echo ''
grep -q "conda initialize" ~/.bashrc || _CONDA_ROOT=${HOME}/miniconda ./conda_bashrc.sh
eval "$(~/miniconda/bin/conda shell.bash hook)"
echo '==> restore conda base environment.'
conda env update -f=base.yml
conda config --add channels conda-forge
conda config --set channel_priority strict
conda update --all
conda clean --all
make init
make deploy
