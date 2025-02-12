#!/bin/bash

yes | sudo apt update
yes | sudo apt install httpd
echo "<h1>Server Details</h1><p><strong>Hostname:</strong> $(hostname)</p><p><strong>IP Adress:</strong> $(hostname -I)</p>"> /var/www/html/index.html
sudo systemctl restart httpd