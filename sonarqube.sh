#!/bin/bash

cp /etc/sysctl.conf /root/sysctl.conf_backup

cat <<EOF > /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=65536
ulimit -n 65536
ulimit -u 4096
EOF

cp /etc/security/limits.conf /root/sec_limit.conf_backup

cat <<EOF> /etc/security/limits.conf
sonarqube   -   nofile   65536
sonarqube   -   nproc    409
EOF

sudo apt-get update -y
sudo apt-get install openjdk-11-jre-headless -y
sudo update-alternatives --config java
