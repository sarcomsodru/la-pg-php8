#!/bin/bash
cd /var/www/html/
git clone https://edmenn@bitbucket.org/edmenn/gestapp.git
mv gestapp/* 
chmod 777 -R /var/www/html/
cd ~/la-pg-php/
docker-compose up -d