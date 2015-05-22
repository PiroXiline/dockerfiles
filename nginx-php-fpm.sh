#!/bin/zsh
./nginx.sh
docker build -t="pyro/nginx-php-fpm" ./phusion-baseimage/nginx/nginx-php-fpm/