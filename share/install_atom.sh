#!/usr/bin/env bash
# Install Atom Editor and plugins
# -------------------------------
echo "Installing Atom editor..........."$(date '+%T')
cd $HOME
wget https://github.com/atom/atom/releases/download/v1.0.19/atom-amd64.deb >/dev/null 2>&1
dpkg --install --force-not-root --root=$HOME atom-amd64.deb >/dev/null 2>&1
rm atom-amd64.deb
apm install minimap file-icons sublime-block-comment