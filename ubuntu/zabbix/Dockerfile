FROM pyro/phusion-baseimage
# Zabbix
ENV DEBIAN_FRONTEND noninteractive
# Install Zabbix-Server
# Install package that adds repo
RUN wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.4-1+trusty_all.deb
RUN dpkg -i zabbix-release_2.4-1+trusty_all.deb
RUN apt-get update
# Install zabbix-server-postgresql
RUN apt-get install zabbix-server-pgsql

RUN \
sed -i '/^DBHost=localhost*/d' /etc/zabbix/zabbix_server.conf && \
sed -i '/^DBSchema=*/d' /etc/zabbix/zabbix_server.conf && \
sed -i '/^DBUser=zabbix*/d' /etc/zabbix/zabbix_server.conf && \
sed -i '/^DBPassword*/d' /etc/zabbix/zabbix_server.conf && \
sed -i '/^DBSocket=/var/run/mysqld/mysqld.sock*/d' /etc/zabbix/zabbix_server.conf && \
sed -i '/^DBPort=*/d' /etc/zabbix/zabbix_server.conf && \

echo 'DBHost=db' >> /etc/zabbix/zabbix_server.conf && \
echo 'DBSchema=zabbix' >> /etc/zabbix/zabbix_server.conf && \
echo 'DBUser=zabbix' >> /etc/zabbix/zabbix_server.conf && \
echo 'DBPassword=password' >> /etc/zabbix/zabbix_server.conf && \
echo 'DBPort=5432' >> /etc/zabbix/zabbix_server.conf && \

sed -i '/^php_value max_execution_time*/d' /etc/php5/fpm/php.ini && \
sed -i '/^php_value memory_limit*/d' /etc/php5/fpm/php.ini && \
sed -i '/^php_value post_max_size*/d' /etc/php5/fpm/php.ini && \
sed -i '/^php_value upload_max_filesize*/d' /etc/php5/fpm/php.ini && \
sed -i '/^php_value max_input_time*/d' /etc/php5/fpm/php.ini && \
sed -i '/^php_value date.timezone*/d' /etc/php5/fpm/php.ini && \

echo 'php_value max_execution_time 300' >> /etc/php5/fpm/php.ini && \
echo 'php_value memory_limit 128M' >> /etc/php5/fpm/php.ini && \
echo 'php_value post_max_size 16M' >> /etc/php5/fpm/php.ini && \
echo 'php_value upload_max_filesize 2M' >> /etc/php5/fpm/php.ini && \
echo 'php_value max_input_time 300' >> /etc/php5/fpm/php.ini && \
echo 'php_value date.timezone UTC' >> /etc/php5/fpm/php.ini

