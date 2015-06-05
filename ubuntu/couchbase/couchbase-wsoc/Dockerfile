# Couchbase with Websockets & Test App (aka main)
# Build from ubuntu-couchbase from updated & customized Ubuntu:Latest
# Default database path /opt/couchbase/var/lib/couchbase/data
# 
FROM pyro/ubuntu-couchbase
# set noninteractive mode
COPY build/main /usr/local/bin/main
COPY build/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# Install basic package, remove document size limit
RUN \
# Install Couchbase C SKD
# go to /tmp for runtime install
  cd /tmp && \
  wget http://packages.couchbase.com/clients/c/couchbase-csdk-setup && \
# modify script for silent installation
  sed -i 's/apt-get -q install/apt-get -y -q install/g' ./couchbase-csdk-setup && \
# run install script
  perl ./couchbase-csdk-setup && \
# remove it
  rm ./couchbase-csdk-setup && \
# Install main packages for main & supervisor to manage two processes in container
  apt-get -y install supervisor libwebsockets3 && \
# Install some additional packages for main
#  apt-get -y install libwebsockets3 libghc-wai-websockets-dev libghc-websockets-dev libwebsockets-dev libwebsockets-test-server libwebsockets3-dbg && \
# change permissions for test websocket binary
  chmod u+x /usr/local/bin/main && \
# afterinstall container cleanup
  apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# add to statup coucbase script line that invokes Websocket app and puts it background
#  sed -i '/# you can omit these settings and everything will still work./ a\\n# Starting Websocket app in background\n/usr/local/bin/main &' /usr/local/bin/couchbase-start && \
# add kill for Websocket app to stop container properly
#  sed -i '/su - couchbase -c "\/opt\/couchbase\/bin\/couchbase-server -- -noinput"/ a\\n# Stopping Websocket app \npkill main' /usr/local/bin/couchbase-start
# Expose Web Administration Port, Couchbase API Port & Internal/External Bucket Port
EXPOSE 8091 8092 9000 11207 11210 11211 18091 18092
# start Couchbase
CMD ["/usr/bin/supervisord"]

# Build (or run script):    docker build -t="pyro/ubuntu-couchbase-wsoc" ./ubuntu/couchbase/couchbase-wsoc/
# Create data container:    docker run -d -v /opt/couchbase/var --name couchbase-wsoc-dbdata pyro/ubuntu-couchbase-wsoc echo 'Data-only couchbase-wsoc container'
# Start one DB container:   docker run -d -p 8091:8091 -p 8092:8092 -p 9000:9000 -p 11207:11207 -p 11210:11210 -p 11211:11211 -p 18091:18091 -p 18092:18092 --volumes-from couchbase-wsoc-dbdata --name couchbase-wsoc pyro/ubuntu-couchbase-wsoc
# this will map inner port 8091 to http://localhost:8091. So you can reach WebUI on http://localhost:8091
