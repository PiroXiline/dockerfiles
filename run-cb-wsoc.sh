#!/bin/bash
docker run -d -v /opt/couchbase/var --name couchbase-wsoc-dbdata pyro/ubuntu-couchbase-wsoc echo 'Data-only couchbase-wsoc container'
docker run -d -p 8091:8091 -p 8092:8092 -p 9000:9000 -p 11207:11207 -p 11210:11210 -p 11211:11211 -p 18091:18091 -p 18092:18092 --volumes-from couchbase-wsoc-dbdata --name couchbase-wsoc pyro/ubuntu-couchbase-wsoc
docker exec -ti couchbase-wsoc /bin/bash