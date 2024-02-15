#!/bin/bash
echo '==> install miniconda'
echo ''
if [[ ! -x ~/${CONDA_PATH:=miniconda3}/bin/conda ]]; then
  tmp=$(mktemp -d)
  curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o $tmp/miniconda.sh
  bash $tmp/miniconda.sh -b -p ~/$CONDA_PATH
  rm -rf $tmp
fi

echo '==> setup conda-forge and install packages'
echo ''
eval "$(~/$CONDA_PATH/bin/conda shell.bash hook)"
conda update conda -y
conda config --add channels conda-forge
conda config --set channel_priority strict
conda update --all -y
conda install -y neovim make gcc git wget fish trash-cli groff tmux binutils powerline-status unzip patch fzf deno rust rust-std-x86_64-unknown-linux-gnu powerline-status bash-completion conda-bash-completion
conda clean --all -y

echo '==> install and login rbw bitwarden cli(unofficial)'
echo ''
echo '==> set cargo home and add path'
echo ''
export CARGO_HOME="$HOME"/.local/cargo
echo '==> install rbw via cargo'
echo ''
cargo install rbw

echo '==> login to bitwarden'
echo ''
while true; do
  read -p 'input bitwarden login email: ' bwemail
  PATH="$GARGO_HOME"/bin:"$PATH" rbw config set email "$bwemail"
  if PATH="$GARGO_HOME"/bin:"$PATH" rbw login; then
    echo "login succeeded."
    break
  else
    echo "retry login bitwarden"
  fi
done

echo '==> install chezmoi'
echo ''
sh -c "$(curl -fsSL git.io/chezmoi)" -- -b ~/.local/bin init --apply hirsaeki
