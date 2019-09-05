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
ENV NIFI_REGISTRY_USER=nifiregistry \
    NIFI_REGISTRY_CONF_DIR=/etc/nifi-registry/conf \
    NIFI_REGISTRY_LOG_DIR=/var/log/nifi-registry \
    NIFI_REGISTRY_RUN_DIR=/var/run/nifi-registry \
    NIFI_REGISTRY_WORK_DIR=/var/lib/nifi-registry \
    NIFI_REGISTRY_DATABASE_REPOSITORY=/grid/nifi-registry/database_repository

# NiFi Registry repos
ADD hdf_repos /tmp/hdf_repos

# Install NiFi Registry
RUN cd /tmp/hdf_repos && yum -y localinstall hdf-select*.rpm 
RUN cd /tmp/hdf_repos && yum -y localinstall nifi-registry*.rpm

# Create User

RUN set -ex; \
    useradd $NIFI_REGISTRY_USER

# Make Directories
RUN set -ex; \
    mkdir -p "$NIFI_REGISTRY_LOG_DIR"; \
    chown "$NIFI_REGISTRY_USER:$NIFI_REGISTRY_USER" "$NIFI_REGISTRY_LOG_DIR"

RUN set -ex; \
    mkdir -p "$NIFI_REGISTRY_RUN_DIR"; \
    chown "$NIFI_REGISTRY_USER:$NIFI_REGISTRY_USER" "$NIFI_REGISTRY_RUN_DIR"

RUN set -ex; \
    mkdir -p "$NIFI_REGISTRY_WORK_DIR"; \
    chown "$NIFI_REGISTRY_USER:$NIFI_REGISTRY_USER" "$NIFI_REGISTRY_WORK_DIR"

RUN set -ex; \
    mkdir -p "$NIFI_REGISTRY_DATABASE_REPOSITORY"; \
    chown "$NIFI_REGISTRY_USER:$NIFI_REGISTRY_USER" "$NIFI_REGISTRY_DATABASE_REPOSITORY"

VOLUME ["$NIFI_REGISTRY_LOG_DIR", "$NIFI_REGISTRY_WORK_DIR", "$NIFI_REGISTRY_DATABASE_REPOSITORY"]

# Cleanup
RUN rm -rf /tmp/hdf_repos

# Add Configs
ADD conf /etc/nifi-registry/conf

# Update NiFi Registry config
ADD nifi-registry.properties /etc/nifi-registry/conf/nifi-registry.properties

# Configure and Start NiFi Registry
ADD bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]
