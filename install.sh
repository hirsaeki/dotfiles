#/bin/bash

DOTPATH=~/.dotfiles

if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"
elif has curl || has wget; then
    tarball="https://github.com/hirsaeki/dotfiles/archive/master.tar.gz"

    if has "curl"; then
        curl -L "$tarball"
    elif has "wget"; then
	wget -O - "$tarball"
    fi | tar "$tarball"

    mv -f dotfile-master "$DOTPATH"
else
    die "curl or wget required"
fi

make $@ install
