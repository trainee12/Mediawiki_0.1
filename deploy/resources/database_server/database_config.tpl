#!/bin/bash

sudo yum update -y
hostnamectl set-hostname dbserver.`hostname -d`
sudo yum install git -y
sudo yum install mariadb-server -y
sudo yum install mariadb -y



sudo systemctl start mariadb
sudo systemctl status mariadbyes
echo -e "\n\n${root_password}\n${root_password}\n\n\nn\n\n " | mysql_secure_installation 
echo -e "CREATE USER '${username}'@'%.ec2.internal' IDENTIFIED BY '${password}';" | mysql -u root -p${root_password}

cat << EOF >> db.sql
GRANT ALL PRIVILEGES ON ${name}.* TO '${username}'@'%.ec2.internal';
FLUSH PRIVILEGES;
SHOW DATABASES;
SHOW GRANTS FOR '${username}'@'%.ec2.internal';
EOF

mysql -u root -p${root_password} < db.sql

systemctl enable mariadb
