#!/bin/bash

# Variables
DOMAIN_NAME="your_domain_or_ip_here"
EMAIL="your_email_here"

# Update and upgrade the package list
sudo apt update && sudo apt upgrade -y

# Install required dependencies
sudo apt install -y software-properties-common apt-transport-https lsb-release ca-certificates

# Add PHP 8.2 repository
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Install PHP 8.2 
sudo apt install -y php8.2  sudo php8.2-zip php8.2-bcmath php8.2-ctype php8.2-fileinfo php8.2-mbstring php8.2-pdo php8.2-mysql php8.2-tokenizer php8.2-xml php8.2-dom libapache2-mod-php8.2

# Install MySQL Server
sudo apt install -y mysql-server

sudo systemctl start mysql
sudo systemctl enable mysql
sudo mysql_secure_installation

# Install Certbot and the Apache plugin
sudo apt install -y certbot python3-certbot-apache

# Obtain and install SSL certificate
sudo certbot --apache -d "linkbank.learna.ac.uk" --non-interactive --agree-tos -m "david.rankin@learna.ac.uk"
sudo systemctl enable certbot.timer


# Restart Apache to apply changes
sudo systemctl restart apache2

# PHP version check
php -v

# MySQL version check
mysql --version

sudo mysql -u root -p
CREATE DATABASE linkbank;
CREATE USER 'linkbank'@'localhost' IDENTIFIED BY 'lb51;c25e+10c7&1ee';

GRANT ALL PRIVILEGES ON linkbank.* TO 'linkbank'@'localhost';

FLUSH PRIVILEGES;


#File Permissions
sudo find /home/linkbank/public -type d -exec chmod 755 {} \;

# Set file permissions
sudo find /home/linkbank/public -type f -exec chmod 644 {} \;

# Set ownership to www-data
sudo chown -R www-data:www-data /home/linkbank/public

# Give the web server user write permissions to the storage directory
sudo chown -R www-data:www-data /home/linkbank/storage

# Give the web server user write permissions to the bootstrap/cache directory
sudo chown -R www-data:www-data /home/linkbank/bootstrap/cache

# Ensure the storage and bootstrap/cache directories have the correct permissions
sudo find /home/linkbank/storage -type d -exec chmod 775 {} \;
sudo find /home/linkbank/storage -type f -exec chmod 664 {} \;

sudo find /home/linkbank/bootstrap/cache -type d -exec chmod 775 {} \;
sudo find /home/linkbank/bootstrap/cache -type f -exec chmod 664 {} \;