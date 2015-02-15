#!/usr/bin/env bash

sudo yum -y update
sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo yum -y install --enablerepo=remi --enablerepo=remi-php55 php php-opcache php-devel php-mbstring php-intl php-pdo
echo 'date.timezone = Asia/Tokyo' | sudo tee --append /etc/php.ini > /dev/null

sudo chown vagrant:vagrant /var/www
