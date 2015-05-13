# vim:set ft=dockerfile:
FROM pyro/phusion-baseimage
# This is naked postgres
ENV DEBIAN_FRONTEND noninteractive

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres postgres

# grab gosu for easy step-down from root
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
&& gpg --verify /usr/local/bin/gosu.asc \
&& rm /usr/local/bin/gosu.asc \
&& chmod +x /usr/local/bin/gosu

# Install postgreSQL
RUN apt-get update
RUN apt-get install -y postgresql postgresql-common postgresql-contrib

# Set locales
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8


RUN mkdir /docker-entrypoint-initdb.d

# Set PostGres envarionment variables
ENV PG_MAJOR 9.4
ENV PG_VERSION 9.4.0-1.pgdg70+1

RUN sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf
RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql
ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data

# Fill up service file
RUN mkdir /etc/service/postgres
RUN echo "#!/usr/bin/bash\npostgres" >> /etc/service/postgres/run
RUN chmod +x /etc/service/postgres/run
# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /var/lib/postgresql/data
# Let's start create entrypoint for initialization of Postgres in container
COPY build/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 5432
CMD ["/sbin/my_init"]
# Build: docker build -t="pyro/postgres" .
# Create data conteiner like: docker run -d -v /var/lib/postgresql/data --name postgres-dbdata pyro/postgres echo Data-only postgres container 
# To launch: docker run --volumes-from postgres-dbdata --name postgres-nginx -e POSTGRES_PASSWORD=mynewpassword -d pyro/postgres