#!/bin/zsh
./phusion-baseimage.sh
docker build -t="pyro/php-fpm-nginx" ./phusion-baseimage/php-fpm/