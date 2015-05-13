FROM pyro/phusion-baseimage
# PHP-FPM for nginx & nginx-data containers
ENV DEBIAN_FRONTEND noninteractive
RUN \
apt-get update && \
# Add upstream php5 repo
add-apt-repository -y ppa:ondrej/php5 && \
# Install all bunch of stuff
apt-get install -y --force-yes php5-cli php5-fpm php5-mysql php5-pgsql php5-sqlite php5-curl php5-gd php5-mcrypt php5-intl php5-imap php5-tidy && \
# Turn off demonization, docker will exit if will be no running foregroun proces
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
# Turn off path fixing
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini && \
# Cleanup
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
# Socket /var/run/php5-fpm.sock but we are not going to use it
# Change socket to port 'cuz socket can't be shared between hosts by definition
sed -i '/^listen/c \
listen = 0.0.0.0:9000' /etc/php5/fpm/pool.d/www.conf && \
# Start build service
mkdir -p /etc/service/phpfpm && \
# Fill up service file
echo "#!/usr/bin/env bash\n/usr/sbin/php5-fpm -c /etc/php5/fpm" >> /etc/service/phpfpm/run && \
chmod +x /etc/service/phpfpm/run
EXPOSE 9000
CMD ["/sbin/my_init"]
# Build: docker build -t="pyro/php-fpm-nginx" .
# To launch: docker run -d --volumes-from nginx-php-fpm-data --name php-fpm-nginx pyro/php-fpm-nginx