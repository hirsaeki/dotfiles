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
conda install -y neovim git wget fish trach-cli groff tmux binutils powerline-status jq yq unzip patch fzf deno natsort rust rust-std-x86_64-unknown-linux-gnu powerline-status bash-completion conda-bash-completion qrcode pillow
conda clean --all -y

eval "$(~/${CONDA_PATH:=miniconda3}/bin/conda shell.bash hook)"

echo '==> install bitwarden cli'
echo ''
if ! type -P bw; then
  tmp=$(mktemp -d)
  cd $tmp
  curl -L "https://vault.bitwarden.com/download/?app=cli&platform=linux" -o bw.zip
  unzip bw.zip
  install -t ~/.local/bin bw
  cd ~/
  rm -rf $tmp
fi

echo '==> login/unlock bitwarden'
echo ''
while [[ -z "$BW_CLIENTID" ]]; do
  printf 'input bitwarden client id(hidden): '
  read -s buf
  printf '\n'
  export BW_CLIENTID="$buf"
  unset buf
done
while [[ -z "$BW_CLIENTSECRET" ]]; do
  printf 'input bitwarden client secret(hidden): '
  read -s buf
  printf '\n'
  export BW_CLIENTSECRET="$buf"
  unset buf
done
while [[ -z "$BW_PASSWORD" ]]; do
  printf 'input bitwarden master password(hidden): '
  read -s buf
  printf '\n'
  export BW_PASSWORD="$buf"
  unset buf
done
bw login ---apikey
export BW_SESSION=$(bw unlock --raw --passwordenv BW_PASSWORD)

echo '==> install chezmoi'
echo ''
sh -c "$(curl -fsSL git.io/chezmoi)" -- -b ~/.local/bin init --apply https://github.com/hirsaeki
