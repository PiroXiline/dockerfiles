#!/bin/bash
./couchbase.sh
docker build -t="pyro/ubuntu-couchbase-wsoc" ./ubuntu/couchbase/couchbase-wsoc
