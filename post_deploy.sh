#!/bin/bash

pip install powerline-status --user
patch --forward -fs ${HOME}/.local/lib/python3.6/site-packages/powerline/bindings/tmux/__init__.py < ./powerline-status.patch
patch --forward -fs ${HOME}/.local/lib/python2.7/site-packages/powerline/bindings/tmux/__init__.py < ./powerline-status.patch
