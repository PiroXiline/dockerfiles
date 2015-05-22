#!/bin/zsh
./ubuntu.sh
docker build -t="pyro/ubuntu-nginx" ./ubuntu/nginx/
