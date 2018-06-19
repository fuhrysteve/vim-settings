#!/bin/bash -euo pipefail

apt install -y software-properties-common python3-dev python3-pip build-essential curl

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
apt update
apt install -y neovim
sudo -H pip3 install -U neovim
