#!/bin/bash
lokkit --disabled --selinux=disabled

yum remove dhclient -y

yum update -y
yum install -y telnet wget rsync
yum install -y system-config-network-tui bind-utils
yum install -y vim-enhanced

yum install -y openssh-clients