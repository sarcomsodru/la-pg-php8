#!/bin/bash
cd /opt/
git clone https://github.com/DevTechpy/la-pg-php8.git
cd /opt/la-pg-php8/
cp .env /var/www/html/
cd /var/www/html/
git clone https://edmenn@bitbucket.org/edmenn/gestapp.git
mv gestapp/* /var/www/html/ 
chmod 777 -R /var/www/html/
cd /opt/la-pg-php8/
docker-compose up -d
