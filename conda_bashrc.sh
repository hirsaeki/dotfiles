#!/bin/bash
cat <<EOF >> .bashrc
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="\$('${_CONDA_ROOT}/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ \$? -eq 0 ]; then
    eval "\$__conda_setup"
else
    if [ -f "${_CONDA_ROOT}/etc/profile.d/conda.sh" ]; then
        . "${_CONDA_ROOT}/etc/profile.d/conda.sh}"
    else
        export PATH="${_CONDA_ROOT}/bin/:\$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export PATH=~/.local/share/tfenv/bin:\$PATH
EOF
