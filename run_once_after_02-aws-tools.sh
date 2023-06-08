#!/bin/bash

# activate conda base
eval "$(~/${CONDA_PATH:=miniconda3}/bin/conda shell.bash hook)"

echo '==> install aws cli v2 <amazon recommends not to use package manager like pip for v2>)'
echo ''
if ! type -P aws; then
  tmp=$(mktemp -d)
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$tmp/awscliv2.zip"
  cd $tmp
  unzip awscliv2.zip && ./aws/install -i ~/.local/share/aws-cli -b ~/.local/bin
  cd ~
  rm -rf $tmp
fi

echo '==> set v2 completion on fish'
echo ''
grep -q "v2/current/bin/aws_completer" ~/.config/fish/config.fish || \
  echo "complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); ~/.local/share/aws-cli/v2/current/bin/aws_completer | sed \'s/ $//\'; end)'" >> ~/.config/fish/config.fish

echo '==> install aws cli v1'
echo ''

if ! type -P aws-v1; then
tmp=$(mktemp -d)
  curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "$tmp/awscli-bundle.zip"
  cd $tmp
  unzip awscli-bundle.zip && ./awscli-bundle/install -i ~/.local/share/aws-cli/v1 -b ~/.local/bin/aws-v1
  cd ~
  rm -rf $tmp
fi

echo '==> set v1 completion on fish'
echo ''
grep -q "v1/bin/aws_completer" ~/.config/fish/config.fish || \
echo "complete --command aws-v1 --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); ~/.local/share/aws-cli-v1/bin/aws_completer | sed \'s/ $//\'; end)'" >> ~/.config/fish/config.fish

echo '==> install aws session-manager-plugin'
echo ''
if ! type -P session-manager-plugin; then
  tmp=$(mktemp -d)
  curl -o $tmp/session-manager-plugin.deb -L https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb
  ar p $tmp/session-manager-plugin.deb data.tar.gz | tar -C $tmp -zx 
  cp $tmp/usr/local/sessionmanagerplugin/bin/session-manager-plugin ~/.local/bin/session-manager-plugin;
  rm -rf $tmp
fi

echo '==> install aws-mfa via pip on conda'
echo ''
if ! type -P aws-mfa; then
  pip install aws-mfa
fi

echo '==> install ssh_ec2 from github'
echo ''
[[ -z "$(type -P ssh_ec2)" ]]; && (
  cd $(mktemp -d)
  curl -OL https://raw.githubusercontent.com/hirsaeki-mki/ssh_ec2/master/ssh_ec2
  install -t ~/.local/bin ssh_ec2
)

