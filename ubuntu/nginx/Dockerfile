FROM pyro/ubuntu
# This is naked nginx
ENV DEBIAN_FRONTEND noninteractive
RUN \
  apt-get update && \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get install -y nginx && \

# Turn off demonization, docker will exit if no running foregroun proces be present
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
# Forward request and error logs to docker log collector
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
# create main data directory
  mkdir -p /var/www/html && \
# change user for container security consern
  chown -R www-data:www-data /var/lib/nginx && \
# Fill up service file (for phusion/baseimage)
# mkdir /etc/service/nginx && \
# echo "#!/usr/bin/bash\nnginx" >> /etc/service/nginx/run && \
# chmod +x /etc/service/nginx/run && \
# Cleanup
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#

# Data VOLUME ["/var/cache/nginx", "/usr/share/nginx/html", "/var/log/nginx", "/var/www/html"]
# Extended VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d"]
EXPOSE 80 443
CMD ["nginx"]
# For phusion/baseimage
# CMD ["/sbin/my_init"]

# Build: docker build -t="pyro/ubuntu-nginx" .
# Create data conteiner like: docker run -d --name nginx-data -v /var/cache/nginx -v /usr/share/nginx/html -v /var/log/nginx -v /var/www/html pyro/nginx echo Data-only container for Nginx
# To launch: docker run -d --volumes-from nginx-data --volumes-from php-fpm-nginx --name nginx pyro/nginx