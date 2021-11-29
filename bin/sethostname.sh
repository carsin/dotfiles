#!/usr/bin/env bash

sudo -v
sudo scutil --set HostName $1
sudo scutil --set LocalHostName $1
sudo scutil --set ComputerName $1
dscacheutil -flushcache
echo "set hostname to $1"
