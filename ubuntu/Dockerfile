FROM ubuntu:latest
# Modified phusion-baseimage
ENV DEBIAN_FRONTEND noninteractive
RUN \
apt-get update && \
apt-get -y upgrade && \
# Install packages like software-properties-common to ease work
apt-get install -y vim curl wget software-properties-common && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Build: docker build -t="pyro/ubuntu" .