FROM pyro/ubuntu
# MAINTAINER Anton Latukha <piroxiline@gmail.com>
# ENV OPENLDAP_VERSION 2.4.31

COPY build/ /etc/ldap.dist/modules
COPY build/entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        ldap-utils \
        slapd \
        vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mv /etc/ldap /etc/ldap.dist

EXPOSE 389

# VOLUME ["/etc/ldap", "/var/lib/ldap"]


ENTRYPOINT ["/entrypoint.sh"]

CMD ["slapd", "-d", "32768", "-u", "openldap", "-g", "openldap"]
# Build (or run script):    docker build -t="pyro/ubuntu-openldap" .
# Create data container:    docker run -d -v /etc/ldap -v /var/lib/ldap --name openldap-data pyro/ubuntu-openldap echo 'OpenLDAP data  container'
# Start one DB container:   docker run -d -p 389:389 -e SLAPD_PASSWORD=password -e SLAPD_DOMAIN=ldap.example.org --volumes-from openldap-data --name openldap pyro/ubuntu-openldap
# 
# ## COMMENTS
# ## Configuration (environment variables)
# 
# For the first run, one has to set at least two environment variables. The first
# 
# SLAPD_PASSWORD
# 
# sets the password for the admin user.
# 
# The second
# 
# SLAPD_DOMAIN
# 
# sets the DC (Domain component) parts. E.g. if one sets it to ldap.example.org, the generated base DC parts would be ...,dc=ldap,dc=example,dc=org.
# 
# There is an optinal third variable
# 
# SLAPD_ORGANIZATION (defaults to $SLAPD_DOMAIN)
# 
# that represents the human readable company name (e.g. Example Inc.).
# 
# The fourth (somewhat) optional variable
# 
# SLAPD_CONFIG_PASSWORD
# 
# allows password protected access to the dn=config branch. This helps to reconfigure the server without interruption (read the official documentation).
# 
# One can load additional schemas provided in the slapd package that are not installed using the
# 
# SLAPD_ADDITIONAL_SCHEMAS
# 
# environment variable with comma-separated enties. As of writing these instructions, there are the following additional schemas available: collective, corba, duaconf, dyngroup, java, misc, openldap, pmi and ppolicy.
# 
# At least one quite common module is neither loaded nor configured by default (I am talking about the memberof overlay). In order to activate this (and possibly other modules in the future), there is another environment variable called
# 
# SLAPD_ADDITIONAL_MODULES
# 
# which can hold comma-separated enties. It will try to run .ldif files with a corresponsing name from th module directory. Currently only memberof is avaliable.
# 
# After the first start of the image (and the initial configuration), these envirnonment variables are not evaluated anymore.