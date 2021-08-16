FROM ubuntu:18.04
MAINTAINER Henry Southgate

ENV DEBIAN_FRONTEND noninteractive

# Install the UniFi GPG key
# RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 06E85760C0A52C50 

# Install CA certs
RUN apt-get -y update && \
    apt-get -y install ca-certificates apt-transport-https


# Update OS and install UniFi v5
# Wipe out auto-generated data
RUN apt-get -y update -q && \
	apt-get -y dist-upgrade

RUN apt-get -y install subversion && \
	apt-get -y autoremove && \
	apt-get -y autoclean 

EXPOSE 3690/tcp

VOLUME /svn/

WORKDIR /svn/


RUN apt-get -y install net-tools

ENTRYPOINT ["svnserve", "-d", "--foreground", "-r", "/svn/"]

