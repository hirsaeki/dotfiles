#!/bin/bash
DOTPATH=$HOME/.dotfiles
GITHUB_URL=https://github.com/hirsaeki/dotfiles
BRANCH=master
TARBALL=https://github.com/hirsaeki/dotfiles/archive/$BRANCH.tar.gz 

if type "git" > /dev/null 2>&1 ; then
    git clone -b $BRANCH --recursive "$GITHUB_URL" "$DOTPATH"
elif type "curl" > /dev/null 2>&1 || type "wget"> /dev/null 2>&1 ; then
    if "curl"> /dev/null 2>&1 ; then
        curl -L "$TARBALL"
    elif has "wget" > /dev/null 2>&1 ; then
      wget -O - "$TARBALL"
    fi | tar "$TARBALL"

    mv -f dotfile-$BRANCH "$DOTPATH"
else
    die "curl or wget required"
fi
cd $DOTPATH
echo 'Initialize dotfile'
./initialize.sh
