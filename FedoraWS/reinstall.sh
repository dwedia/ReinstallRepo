#!/bin/bash

# install ansible-core if not already installed
if [ ! -f /usr/bin/ansible ]; 
then
    sudo dnf install -y ansible-core;
    echo "Ansible-core has been installed, running install playbook";
else
    echo "Ansible-core already installed, running playbook"
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

# Check for distribution
DISTRO=$(cat /etc/os-release | grep PRETTY | awk -F '"' '{print $2}' | awk '{print $1}')

# setup firewall with ufw, if Distribution is Debian
if [ "Debian" = $DISTRO ];
then
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw enable
fi

# setup firewall with firewalld, if Distribution is Fedora
if [ "Fedora" = $DISTRO ];
then
    sudo firewall-cmd --set-default-zone=drop
    sudo firewall-cmd --runtime-to-permanent
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-all
fi



#### Missing:
# better lock screen and i3lock
