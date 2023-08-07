#!/bin/bash

Since Silverblue uses rpm-ostree, not dnf, we need to use that to install a few packages, that wont run in Distrobox.

# Install packages
rpm-ostree install ansible-core distrobox terminator gnome-shell-extension-pop-shell vim
