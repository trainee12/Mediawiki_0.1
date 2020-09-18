#!/bin/bash

sudo yum update -y

cat << EOF >> database.sql
GRANT ALL PRIVILEGES ON ${name}.* TO '${username}'@'localhost';
FLUSH PRIVILEGES;
SHOW DATABASES;
SHOW GRANTS FOR '${username}'@'localhost';
EOF


hostnamectl set-hostname dbserver.`hostname -d`
sudo yum install git -y
sudo yum install mariadb-server -y
sudo yum install mariadb -y



sudo systemctl start mariadb
#sudo systemctl status mariadb

echo -e "\n\n${root_password}\n${root_password}\n\n\n\n\n\n " | mysql_secure_installation 
echo -e "CREATE USER '${username}'@'localhost' IDENTIFIED BY '${password}';" | mysql -u root -p${root_password}


mysql -u root -p${root_password} < database.sql
systemctl enable mariadb
