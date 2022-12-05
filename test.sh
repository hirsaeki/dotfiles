#!/bin/bash
echo '==> login/unlock bitwarden'
echo ''
while [[ -z "$BW_CLIENTID" ]]; do
  printf 'input bitwarden client id(hidden): '
  read -s buf
  printf '\n'
  export BW_CLIENTID=$buf
  unset buf
done
while [[ -z "$BW_CLIENTSECRET" ]]; do
  printf 'input bitwarden client secret(hidden): '
  read -s buf
  printf '\n'
  export BW_CLIENTSECRET=$buf
  unset buf
done
while [[ -z "$BW_PASSWORD" ]]; do
  printf 'input bitwarden master password(hidden): '
  read -s buf
  printf '\n'
  export BW_PASSWORD=$buf
  unset buf
done
bw login --apikey
export BW_SESSION=$(bw unlock --raw --passwordenv BW_PASSWORD)
chezmoi apply
