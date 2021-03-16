#!/bin/bash
sudo yum install -y httpd
sudo yum install -y ruby
sudo yum install -y wget
cd /home/ec2-user
wget https://aws-codedeploy-eu-central-1.s3.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo systemctl start httpd &> startup.log
sudo service codedeploy-agent start
sudo echo ' ' >> /etc/httpd/conf/httpd.conf
sudo echo '<VirtualHost *:80>' >> /etc/httpd/conf/httpd.conf
sudo echo '    ProxyPreserveHost On' >> /etc/httpd/conf/httpd.conf
sudo echo '    ProxyPass / http://127.0.0.1:5000/' >> /etc/httpd/conf/httpd.conf
sudo echo '    ProxyPassReverse / http://127.0.0.1:5000/' >> /etc/httpd/conf/httpd.conf
sudo echo '    ErrorLog ${APACHE_LOG_DIR}helloapp-error.log' >> /etc/httpd/conf/httpd.conf
sudo echo '    CustomLog ${APACHE_LOG_DIR}helloapp-access.log common' >> /etc/httpd/conf/httpd.conf
sudo echo '</VirtualHost>' >> /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd
