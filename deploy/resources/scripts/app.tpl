#!/bin/bash

sudo yum update -y
sudo amazon-linux-extras install ansible2
touch mediawiki.yaml
cat << EOF >> mediawiki.yaml 
---
- hosts: localhost
  ignore_errors: yes
  tasks:
  - name: Installation
    shell: yum install httpd php php-mysql php-gd php-xml php-mbstring -y
  - name: Download
    shell: cd /home/ec2-user ;wget https://releases.wikimedia.org/mediawiki/1.26/mediawiki-1.26.3.tar.gz
  - name: Install with symlink
    shell: cd /var/www ;  tar -zxf /home/ec2-user/mediawiki-1.26.3.tar.gz ; ln -s mediawiki-1.26.3/ mediawiki
  - name: Configure
    shell: sed -i "s-/var/www/html-/var/www/mediawiki-g" /etc/httpd/conf/httpd.conf
  - name: Ownership change
    shell: chown -R apache:apache /var/www/mediawiki
  - name: Restart
    shell: service httpd restart
EOF
ansible-playbook mediawiki.yaml