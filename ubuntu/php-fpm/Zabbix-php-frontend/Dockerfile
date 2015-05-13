FROM pyro/php-fpm-nginx
# Zabbix-frontend php
ENV DEBIAN_FRONTEND noninteractive
# Install package that adds repo
RUN wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb
RUN dpkg -i zabbix-release_2.4-1+trusty_all.deb
RUN apt-get update
# Install Zabbix-frontend
RUN apt-get install zabbix-frontend-php