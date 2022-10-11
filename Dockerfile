FROM php:8.1-fpm
RUN apt-get update && \
    apt-get install -y --no-install-recommends libssl-dev zlib1g-dev curl git unzip netcat libxml2-dev libpq-dev libzip-dev && \
    pecl install apcu && \ apt-get install -y wget && \
    docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install -j$(nproc) zip opcache intl pdo_pgsql pgsql && \
    docker-php-ext-enable apcu pdo_pgsql sodium && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY .env /var/www/html/
#COPY construtor.sh /var/www/html
#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet
RUN mv composer.phar /usr/local/bin/composer
#RUN php composer-setup.php
#RUN php -r "unlink('composer-setup.php');"
#RUN sudo mv composer.phar /usr/local/bin/composer
#RUN chmod +x /var/www/html/construtor.sh
#ENTRYPOINT ["/var/www/html/contrutor.sh"]
WORKDIR /var/www/html
#RUN git clone https://edmenn@bitbucket.org/edmenn/gestapp.git
#RUN mv gestapp/*  ./
RUN ls -la
#RUN chmod 777 -R /var/www/html/ 
RUN composer install
RUN php artisan migrate
RUN php artisan db:seed
RUN php artisan serve
RUN php artisan key:generate
