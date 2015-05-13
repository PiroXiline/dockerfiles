#!/bin/zsh
./ubuntu.sh
docker build -t="pyro/ubuntu-couchbase" ./ubuntu/couchbase/
