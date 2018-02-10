#!/bin/sh

yum remove -y NetworkManager* firewalld*

yum install epel-release -y
yum update -y
yum install -y ansible bind-utils certbot git htop iftop iptables-services net-tools tcpdump wget yum-utils

curl https://raw.githubusercontent.com/corysm1th/centos7_minimal_golden/master/runonce_setup.sh | sh
mkdir .ssh
touch .ssh/authorized_keys
chmod 700 .ssh
chmod 600 .ssh/authorized_keys

shutdown -r now
