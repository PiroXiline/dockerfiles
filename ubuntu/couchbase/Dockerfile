# Build from updated customized Ubuntu:Latest
# Deal with error /opt/couchbase/etc/couchbase_init.d: 47: : error setting limit (Operation not permitted)

# Default database path /opt/couchbase/var/lib/couchbase/data
# 
FROM pyro/ubuntu

# ENV CB_VERSION		3.0.3 enterprice
# Receive a package from URL - the hole in package building system for developers
ENV CB_RELEASE_URL	http://builder.hq.couchbase.com/get
# The version ov package with buld number
ENV CB_PACKAGE		couchbase-server-enterprise_debian7_x86_64_3.0.3-1718-rel.deb

# add Couchbase startup script
COPY build/couchbase-start /usr/local/bin/couchbase-start

# Install basic package, remove document size limit
RUN \
# set noninteractive mode for installation of packages
  export DEBIAN_FRONTEND=noninteractive && \
# uncomment multiverse sources
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
# update package information
  apt-get update && \
# upgrade the system
#  apt-get -y upgrade && \
# install requireg dependencies like old libssl0 (really still needed?)
  apt-get -y install vim wget curl librtmp0 python && \
# get the package from building system
  wget $CB_RELEASE_URL/$CB_PACKAGE -O $CB_PACKAGE && \
# install it locally
  dpkg -i $CB_PACKAGE && \
# delete package
  rm $CB_PACKAGE && \
# afterinstall container cleanup
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
# set right permissions for entry point script
  chmod u+x-rw /usr/local/bin/couchbase-start && \
# Modify /etc/passwd to add a login shell, otherwise running
#    su - couchbase -c "/opt/couchbase/bin/couchbase-server -- -noinput"
# will give an error: "This account is currently not available."
# This is only an issue on Couchbase Server 3.x, and it's a no-op on 2.x
sed -i -e 's/\/opt\/couchbase:\/usr\/sbin\/nologin/\/opt\/couchbase:\/bin\/bash/' /etc/passwd

# Expose Web Administration Port, Couchbase API Port & Internal/External Bucket Port
EXPOSE 8091 8092 11207 11210 11211 18091 18092

# start Couchbase
CMD ["/usr/local/bin/couchbase-start"]

# Build (or run script):    docker build -t="pyro/ubuntu-couchbase" ./ubuntu/couchbase/
# Create data container:    docker run -d -v /opt/couchbase/var --name couchbase-dbdata pyro/ubuntu-couchbase echo 'Data-only couchbase container'
# Start one DB container:   docker run -d -p 8091:8091 --volumes-from couchbase-dbdata --name couchbase pyro/ubuntu-couchbase
# this will map inner port 8091 to http://localhost:8091. So you can reach WebUI on http://localhost:8091
