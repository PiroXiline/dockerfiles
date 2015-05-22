#!/bin/bash
# Create a data only container
docker run -d --name nginx-wsoc-data -v /var/cache/nginx -v /usr/share/nginx/html -v /var/log/nginx -v /var/www/html pyro/ubuntu-nginx-wsoc echo 'Data-only container for Nginx'
# Create a runtime container
docker run -p 80:80 -p 443:443 -d --volumes-from nginx-wsoc-data --name nginx-wsoc pyro/ubuntu-nginx-wsoc
#docker exec -it couchbase-wsoc /bin/bash