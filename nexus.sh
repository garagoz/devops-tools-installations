#!/bin/bash

sudo apt update
sudo apt install openjdk-8-jre-headless wget -y

sudo useradd -d /opt/nexus -s /bin/bash nexus
sudo passwd nexus

#cat <<EOF > /etc/security/limits.d/nexus.conf
#nexus - nofile 65536
#EOF

cd /opt
wget https://download.sonatype.com/nexus/3/nexus-3.41.1-01-unix.tar.gz
tar xzfv nexus-3.41.1-01-unix.tar.gz

mv nexus-3.41.1-01 nexus
#mv sonatype-work /opt/
chown -R nexus:nexus /opt/nexus /opt/sonatype-work

cat <<EOF > /opt/nexus/bin/nexus.rc
run_as_user="nexus"
EOF

sed -i 's/Xms2073m/Xms1024m/g' /opt/nexus/bin/nexus.vmoptions
sed -i 's/Xmx2073m/Xmx1024m/g' /opt/nexus/bin/nexus.vmoptions
sed -i 's/MaxDirectMemorySize=2073m/MaxDirectMemorySize=1024m/g' /opt/nexus/bin/nexus.vmoptions

# sudo vim /opt/sonatype-work/nexus3/etc/nexus.properties
# application-host=127.0.0.1

cat <<EOF > /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start nexus.service
sudo systemctl enable nexus.service

# http://server_IP:8081
