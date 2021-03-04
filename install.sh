#/bin/bash

DOTPATH=~/.dotfiles

if type "git" > /dev/null 2>&1 ; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"
elif type "curl" > /dev/null 2>&1 || type "wget"> /dev/null 2>&1 ; then
    tarball="https://github.com/hirsaeki/dotfiles/archive/conda.tar.gz"

    if "curl"> /dev/null 2>&1 ; then
        curl -L "$tarball"
    elif has "wget" > /dev/null 2>&1 ; then
      wget -O - "$tarball"
    fi | tar "$tarball"

    mv -f dotfile-master "$DOTPATH"
else
    die "curl or wget required"
fi

cd $DOTPATH
make $@ install
