FROM pyro/ubuntu
# Saltstack minion
RUN add-apt-repository ppa:saltstack/salt
RUN sudo apt-get update
RUN apt-get -y install salt-minion
RUN apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Build: docker build -t="pyro/ubuntu-salt" .