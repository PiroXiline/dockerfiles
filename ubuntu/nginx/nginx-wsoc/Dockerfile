FROM pyro/ubuntu-nginx
# This is naked nginx
# main data directory is /var/www/html
# user, group www-data:www-data
ENV DEBIAN_FRONTEND noninteractive
# Copy Websocket js html
COPY build/index.html /var/www/html/index.html
# Copy config file
COPY build/default /etc/nginx/sites-available/default
# Make html permissions to make it parseble by nginx
RUN chown www-data:www-data /var/www/html/index.html
# Data VOLUME ["/var/cache/nginx", "/usr/share/nginx/html", "/var/log/nginx", "/var/www/html"]
# Extended VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d"]
EXPOSE 80 443
# It is already demonized in pyro/ubuntu-nginx
CMD ["nginx"]
# For phusion/baseimage
# CMD ["/sbin/my_init"]

# Build: docker build -t="pyro/ubuntu-nginx-wsoc" .
# Create data conteiner: docker run -d --name nginx-wsoc-data -v /var/cache/nginx -v /usr/share/nginx/html -v /var/log/nginx -v /var/www/html pyro/ubuntu-nginx-wsoc echo 'Data-only container for Nginx'
# To launch: docker run -p 80:80 -p 443:443 -d --volumes-from nginx-wsoc-data --name nginx-wsoc pyro/ubuntu-nginx-wsoc