#!/bin/bash
sudo timedatectl set-timezone Europe/Madrid
echo "-----BEGIN OPENSSH PRIVATE KEY-----
the key
-----END OPENSSH PRIVATE KEY-----" > /home/rocky/.ssh/rsa.key
sudo dnf -y install dnf-utils epel-release
sudo dnf -y install wget curl traceroute telnet
sudo dnf -y install bash-completion vim nano
