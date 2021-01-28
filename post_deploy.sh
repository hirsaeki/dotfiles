#!/bin/bash
set -x
curl -sL curl https://bootstrap.pypa.io/get-pip.py|python3
pip install powerline-status -U
for i in $(find ~/.local/lib -path "*/tmux/__init__.py"); do
  patch --forward -fs ${i} < ./powerline-status.patch
done
for i in $(find ~/.local/lib -path "*/tmux/powerline.conf"); do
  sed -i '/tmux\/powerline.conf/s#.*#source '${i}'#' .tmux.conf
done
