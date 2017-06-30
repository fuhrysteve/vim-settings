#!/bin/bash -euo pipefail

apt-get install -y software-properties-common python-dev python-pip python3-dev python3-pip

add_ppa() {
  for i in "$@"; do
    grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
      echo "Adding ppa:$i"
      sudo add-apt-repository -y ppa:$i
    else
      echo "ppa:$i already exists"
    fi
  done
}

add_ppa neovim-ppa/stable
apt-get update
apt-get install -y neovim
sudo -H pip3 install -U neovim
sudo -H pip install -U neovim
