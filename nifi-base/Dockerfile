FROM centos:7.4.1708
MAINTAINER nashebismaily

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync less iproute net-tools bind-utils initscripts
RUN yum update -y libselinux

# java
RUN yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

# Add enviornemnt variables
ENV NIFI_USER=nifi \
    NIFI_CONF_DIR=/etc/nifi/conf \
    NIFI_LOG_DIR=/var/log/nifi \
    NIFI_WORK_DIR=/var/lib/nifi \
    NIFI_DATABASE_REPOSITORY=/grid/nifi/database_repository \
    NIFI_FLOWFILE_REPOSITORY=/grid/nifi/flowfile_repository \
    NIFI_CONTENT_REPOSITORY=/grid/nifi/content_repository \
    NIFI_PROVENANCE_REPOSITORY=/grid/nifi/provenance_repository

# NiFi repos
ADD hdf_repos /tmp/hdf_repos

# Install NiFi
RUN cd /tmp/hdf_repos && yum -y localinstall hdf-select*.rpm 
RUN cd /tmp/hdf_repos && yum -y localinstall nifi*.rpm

# Make Directories
RUN set -ex; \
    mkdir -p "$NIFI_LOG_DIR"; \
    chown "$NIFI_USER:$NIFI_USER" "$NIFI_LOG_DIR"

RUN set -ex; \
    mkdir -p "$NIFI_WORK_DIR"; \
    chown "$NIFI_USER:$NIFI_USER" "$NIFI_WORK_DIR"

RUN set -ex; \
    mkdir -p "$NIFI_DATABASE_REPOSITORY"; \
    chown "$NIFI_USER:$NIFI_USER" "$NIFI_DATABASE_REPOSITORY"

RUN set -ex; \
    mkdir -p "$NIFI_FLOWFILE_REPOSITORY"; \
    chown "$NIFI_USER:$NIFI_USER" "$NIFI_FLOWFILE_REPOSITORY"

RUN set -ex; \
    mkdir -p "$NIFI_CONTENT_REPOSITORY"; \
    chown "$NIFI_USER:$NIFI_USER" "$NIFI_CONTENT_REPOSITORY"

RUN set -ex; \
    mkdir -p "$NIFI_PROVENANCE_REPOSITORY"; \
    chown "$NIFI_USER:$NIFI_USER" "$NIFI_PROVENANCE_REPOSITORY"

VOLUME ["$NIFI_LOG_DIR", "$NIFI_WORK_DIR", "$NIFI_DATABASE_REPOSITORY", "$NIFI_FLOWFILE_REPOSITORY", "$NIFI_CONTENT_REPOSITORY", "$NIFI_PROVENANCE_REPOSITORY"]

# Cleanup
RUN rm -rf /tmp/hdf_repos

# Update NiFi config
ADD nifi.properties /etc/nifi/conf/nifi.properties

# Configure and Start NiFi
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]

