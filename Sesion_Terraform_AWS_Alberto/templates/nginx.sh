#!/bin/bash
sudo timedatectl set-timezone Europe/Madrid
sudo dnf -y install dnf-utils epel-release
sudo dnf -y install nginx
sudo systemctl enable nginx
sudo systemctl start nginx
