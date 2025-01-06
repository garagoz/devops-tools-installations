#!/bin/bash

sudo apt update
sudo apt install openjdk-11-jre-headless wget -y

sudo useradd -d /opt/nexus -s /bin/bash nexus
sudo passwd nexus

cat <<EOF > /etc/security/limits.d/nexus.conf
nexus - nofile 65536
EOF

wget https://download.sonatype.com/nexus/3/nexus-3.41.1-01-unix.tar.gz
tar xzfv nexus-3.41.1-01-unix.tar.gz

mv nexus-3.41.1-01 /opt/nexus
mv sonatype-work /opt/
chown -R nexus:nexus /opt/nexus /opt/sonatype-work

cat <<EOF > /opt/nexus/bin/nexus.rc
run_as_user="nexus"
EOF

sed 's/Xms2703m/Xms1024m/g' /opt/nexus/bin/nexus.vmoptions
sed 's/Xmx2703m/Xmx1024m/g' /opt/nexus/bin/nexus.vmoptions
sed 's/MaxDirectMemorySize=2703m/MaxDirectMemorySize=1024m/g' /opt/nexus/bin/nexus.vmoptions
# 1930282990
