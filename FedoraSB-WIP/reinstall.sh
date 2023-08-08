#!/bin/bash

# install the community general flatpak module
ansible-galaxy collection install community.general

# Set up git config user
git config --global user.name "Ramiraz80"
git config --global user.email "eric@bellaiche.net"

# run the apt install playbook
if [ -f /usr/bin/ansible ]; 
then
    ansible-playbook reinstall-playbook.yml -K;
fi

# Check for distribution
DISTRO=$(cat /etc/os-release | grep PRETTY | awk -F '"' '{print $2}' | awk '{print $1}')

#### Missing:
# better lock screen and i3lock
