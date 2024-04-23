#!/bin/bash
sudo timedatectl set-timezone Europe/Madrid
sudo dnf -y install dnf-utils epel-release
sudo dnf -y install wget curl traceroute telnet
sudo dnf -y install bash-completion vim nano
