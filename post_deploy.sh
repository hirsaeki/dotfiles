#!/bin/bash
set -x
. ./.profile
for i in $(find ~/miniconda/lib -path "*/tmux/__init__.py"); do
  patch --forward -fs ${i} < ./powerline-status.patch
done
for i in $(find ~/miniconda/lib -path "*/tmux/powerline.conf"); do
  sed -i '/tmux\/powerline.conf/s#.*#source '${i}'#' .tmux.conf
done

eval "$(~/miniconda/bin/conda shell.bash hook)"

if ! grep -qF ".deno" $HOME/.profile; then
  echo "export DENO_INSTALL=\$HOME/.deno" | tee -a $HOME/.profile
  echo "export PATH=\$DENO_INSTALL/bin:$PATH" | tee -a $HOME/.profile
fi

/usr/bin/env fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
grep -q theme-agnoster .config/fish/fish_plugins || cat <<EOF >> .config/fish/fish_plugins
danhper/fish-ssh-agent
oh-my-fish/theme-agnoster
jethrokuan/fzf
EOF
/usr/bin/env fish -c "fisher update"
patch --forward -fs ~/.config/fish/functions/fish_prompt.fish < ./fish_prompt.patch
/usr/bin/env fish -c "abbr -a vi nvim"
