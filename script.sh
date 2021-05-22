#!/usr/bin/env bash

# netplan2NM.sh
# Ubuntu server 20.04  Change from netplan to NetworkManager for all interfaces

echo 'Changing netplan to NetowrkManager on all interfaces'
# backup existing yaml file
cd /etc/netplan
cp 01-netcfg.yaml 01-netcfg.yaml.BAK

# re-write the yaml file
cat << EOF > /etc/netplan/01-netcfg.yaml
# This file describes the network interfaces available on your system
# For more information, see netplan(5).
network:
  version: 2
  renderer: NetworkManager
EOF

# setup netplan for NM
netplan generate
netplan apply
# make sure NM is running
systemctl enable NetworkManager.service
systemctl restart NetworkManager.service

echo 'Done!'
