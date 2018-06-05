if [ "$MSYSCON" = "mintty.exe" ] || grep -s Microsoft /proc/version; then
  [ ! -e ${HOME}/.sol_dark_mintty ] && wget -O ${HOME}/.sol_dark_mintty https://raw.githubusercontent.com/mavnn/mintty-colors-solarized/master/sol.dark
  . ~/.sol_dark_mintty
fi
[ ! -e ${HOME}/.dircolors.ansi-dark ] && wget -O ${HOME}/.dircolors.ansi-dark https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark
