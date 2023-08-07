#!/bin/bash

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

# Check for distribution
DISTRO=$(cat /etc/os-release | grep PRETTY | awk -F '"' '{print $2}' | awk '{print $1}')

# setup firewall with ufw, if Distribution is Debian
if [ "Debian" = $DISTRO ];
then
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw enable
fi



#### Missing:
# better lock screen and i3lock
