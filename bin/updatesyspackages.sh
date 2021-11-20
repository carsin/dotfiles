#!/usr/bin/env bash
echo "Updating packages across system"
sudo -v
echo "Upgrading homebrew packages..."
brew outdated
brew upgrade
echo "Finished with homebrew"
echo "Updating outdated rubygems packages..."
gem outdated
sudo gem update
echo "Finished with rubygems"
echo "Updating outdated pip packages..."
pip3 list --outdated
pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip3 install -U
echo "Finished with pip"
echo "Updating outdated npm packages..."
npm outdated -g
npm upgrade -g
echo "Finished with npm"
echo "Updating outdated Mac app store applications..."
mas outdated
mas upgrade
echo "Finished with mas"
echo "Successfully upgraded outdated system packages!"
