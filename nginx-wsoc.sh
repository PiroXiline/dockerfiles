#!/bin/zsh
./nginx.sh
docker build -t="pyro/ubuntu-nginx-wsoc" ./ubuntu/nginx/nginx-wsoc
