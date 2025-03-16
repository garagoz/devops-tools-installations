#!/bin/bash
sudo apt-get update && sudo apt-get -y install lsb-release ca-certificates curl gnupg2
curl -o- https://artifacts.opensearch.org/publickeys/opensearch.pgp | sudo gpg --dearmor --batch --yes -o /usr/share/keyrings/opensearch-keyring
echo "deb [signed-by=/usr/share/keyrings/opensearch-keyring] https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/2.x/apt stable main" | sudo tee /etc/apt/sources.list.d/opensearch-dashboards-2.x.list
sudo apt-get update -y
sudo apt-get install opensearch-dashboards
sudo systemctl enable opensearch-dashboards
sudo systemctl start opensearch-dashboards

# sudo vi /etc/opensearch-dashboards/opensearch_dashboards.yml
# Use 0.0.0.0 to bind to any available interface.
# server.host: 0.0.0.0

sudo systemctl restart opensearch-dashboards