#!/bin/bash
cat <<EOF >> .bashrc
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${_CONDA_PATH}' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${_CONDA_PATH}" ]; then
        . "${_CONDA_PATH}"
    else
        export PATH="${_CONDA_PATH%/*}:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
