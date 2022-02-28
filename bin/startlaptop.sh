#!/bin/bash

sudo -v
egpu-switcher switch internal 
startx
./displays/laptop.sh
