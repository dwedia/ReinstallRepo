#!/bin/bash

# Check for distribution
DISTRO=$(cat /etc/os-release | grep PRETTY | awk -F '"' '{print $2}' | awk '{print $1}')

echo "Distrobution is $DISTRO, using correct options"

# Install ansible-core on Fedora
if [ "Fedora" = $DISTRO ];
then
  if [ ! -f /usr/bin/ansible ]; 
  then
    sudo dnf install -y ansible-core;
    echo "Ansible-core has been installed, running install playbook";
  else
    echo "Ansible-core already installed, running playbook"
  fi
fi

# Install ansible-core on Debian
if [ "Debian" = $DISTRO ];
then
  if [ ! -f /usr/bin/ansible ]; 
  then
    sudo apt install -y ansible-core;
    echo "Ansible-core has been installed, running install playbook";
  else
    echo "Ansible-core already installed, running playbook"
  fi
fi

# install the community general flatpak module
ansible-galaxy collection install community.general

# run the apt install playbook
if [ -f /usr/bin/ansible ]; 
then
  ansible-playbook reinstall-playbook.yml -K;
fi

# Set up git config user
git config --global user.name "Ramiraz80"
git config --global user.email "eric@bellaiche.net"

# Set up firewall with firewalld if Distribution is Fedora
if [ "Fedora" = $DISTRO ];
then
  firewall-cmd --set-default-zone=drop
  firewall-cmd --runtime-to-permanent
  firewall-cmd --reload
fi

# setup firewall with ufw, if Distribution is Debian
if [ "Debian" = $DISTRO ];
then
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw enable
fi
