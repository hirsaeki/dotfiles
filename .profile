if [ "$MSYSCON" == "mintty.exe" ]; then
  [ ! -e .sol_dark_mintty ] && wget -O ${HOME}/.sol_dark_mintty https://raw.githubusercontent.com/mavnn/mintty-colors-solarized/master/sol.dark
  source ${HOME}/.sol_dark_mintty
fi
alias ls="ls --color=auto"
cd ~
