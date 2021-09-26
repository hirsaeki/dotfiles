# for x2go
if type x2goagent 2> /dev/null ; then
  XDG_DATA_DIRS=/usr/share/mate:/usr/share/mate:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
  GSETTINGS_SCHEMA_DIR=$XDG_DATA_DIRS
  export XDG_DATA_DIRS GSETTINGS_SCHEMA_DIR
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if type vi > /dev/null 2>&1; then
  export EDITOR="vi"
fi

if ! type less > /dev/null 2>&1; then
  export PAGER="less"
fi
