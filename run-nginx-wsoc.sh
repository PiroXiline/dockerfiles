#!/bin/bash
# Create a data only container
if docker ps -a|grep -q nginx-wsoc-data ; then
    echo 'Nginx data container found, using existing one.'
else
    echo 'Container with nginx data not found. Creating new one.'
    docker run -d --name nginx-wsoc-data -v /var/cache/nginx -v /usr/share/nginx/html -v /var/log/nginx -v /var/www/html pyro/ubuntu-nginx-wsoc echo 'Data-only Nginx container'
fi
# Create a runtime container
if docker ps -a|grep nginx-wsoc|grep -q -v nginx-wsoc-dbdata ; then
    echo 'nginx-wsoc execution container found, replacing with new one.'
    echo 'Stopping container nginx-wsoc.'
    docker stop nginx-wsoc
    echo 'Deleting container nginx-wsoc.'
    docker rm nginx-wsoc
else echo 'nginx-wsoc execution container not found.'
fi
echo 'Starting nginx-wsoc execution container.'
docker run -p 80:80 -p 443:443 -d --volumes-from nginx-wsoc-data --name nginx-wsoc pyro/ubuntu-nginx-wsoc
#docker exec -it nginx-wsoc /bin/bash