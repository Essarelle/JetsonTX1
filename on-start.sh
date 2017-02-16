#!/bin/bash
# script for mounting drives and sourcing bashrc profile for proper function
#sudo mount -t ext4 /dev/sda1 /opt
cd ~
. .bashrc
#cd /opt/
sudo swapon swapfile
