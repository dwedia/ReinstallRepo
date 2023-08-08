#!/bin/bash

Since Silverblue uses rpm-ostree, not dnf, we need to use that to install a few packages, that wont run in Distrobox.

# Install packages
rpm-ostree install i3 ansible-core distrobox terminator gnome-shell-extension-pop-shell vim lxpolkit https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm