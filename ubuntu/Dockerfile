FROM ubuntu:latest
# Modified phusion-baseimage
RUN \
# add resolve name to host machine 
echo '172.17.42.1 host'>> /etc/hosts && \
apt-get update && \
apt-get -y upgrade && \
# Install packages like software-properties-common to ease work
apt-get -y install vim curl wget software-properties-common && \
apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Build: docker build -t="pyro/ubuntu" .