#!/bin/bash

# Opensearch installation
sudo apt-get update && sudo apt-get -y install lsb-release ca-certificates curl gnupg2
curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-2.x.list
sudo apt-get update -y
sudo env OPENSEARCH_INITIAL_ADMIN_PASSWORD=Opensearch123! apt-get install opensearch -y
sudo systemctl enable opensearch
sudo systemctl start opensearch

# For testing
# curl -X GET https://localhost:9200 -u 'admin:<custom-admin-password>' --insecure
# curl -k -u admin:Opensearch123! https://44.200.60.162:9200/kubernetes-events-*/_count --insecure
# curl -k -u admin:Opensearch123! https://44.200.60.162:9200/_cat/indices --insecure

# open this and edit
# sudo vim /etc/opensearch/opensearch.yml
# edit this network.host: localhost > network.host: 0.0.0.0

sudo systemctl restart opensearch