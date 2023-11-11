#!/bin/bash

# Since Silverblue uses rpm-ostree, not dnf, we need to use that to install a few packages, that wont run in Distrobox.

# check if rpm-ostree is idle
ostreeStatus=$(rpm-ostree status | grep State | awk '{print $2}')

if [ "$ostreeStatus" == "idle" ]; then
    # Install packages
    rpm-ostree install i3 rofi ansible-core distrobox terminator gnome-shell-extension-pop-shell vim lxpolkit https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    echo "Rebooting, to ensure that the new packages are installed"
    sleep 5
    systemctl reboot
else
    echo "rpm-ostree is busy, wait a minute and try again. See status with rpm-ostree status"
fi
