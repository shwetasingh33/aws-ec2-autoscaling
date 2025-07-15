#!/bin/bash
# User data script to install Apache and start web server
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Deployed via EC2 Auto Scaling - $(hostname)</h1>" > /var/www/html/index.html
