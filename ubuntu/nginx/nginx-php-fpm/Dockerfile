FROM pyro/nginx
# Take naked nginx and give it configuration for php
ENV DEBIAN_FRONTEND noninteractive
ADD build/default /etc/nginx/sites-available/default
# Build: docker build -t="pyro/nginx-php-fpm" .
# Create data conteiner like: docker run -d --name nginx-php-fpm-data -v /var/cache/nginx -v /usr/share/nginx/html -v /var/log/nginx -v /var/www/html pyro/nginx-php-fpm echo Data-only container for Nginx
# To launch: docker run -d --link php-fpm-nginx:php-fpm-nginx --volumes-from nginx-php-fpm-data --volumes-from php-fpm-nginx --name nginx-php-fpm pyro/nginx-php-fpm
