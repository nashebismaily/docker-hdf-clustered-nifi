FROM centos:7.4.1708
MAINTAINER nashebismaily

# Java
RUN yum -y install java-1.8.0-openjdk java-1.8.0-openjdk-devel

# Add enviornemnt variables
ENV ZOO_USER=zookeeper \
    ZOO_CONF_DIR=/etc/zookeeper/conf \
    ZOO_DATA_DIR=/grid/zookeeper/data \
    ZOO_LOG_DIR=/var/log/zookeeper \
    ZOO_PORT=2181 \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=10 \
    ZOO_SYNC_LIMIT=5

# Zookeeper repos
ADD hdf_repos /tmp/hdf_repos

# Install zookeeper
RUN cd /tmp/hdf_repos && yum -y localinstall hdf-select*.rpm
RUN cd /tmp/hdf_repos && yum -y localinstall zookeeper*.rpm

# Make dirs
RUN set -ex; \
    mkdir -p "$ZOO_DATA_DIR"; \
    chown "$ZOO_USER:$ZOO_USER" "$ZOO_DATA_DIR"

RUN set -ex; \
    mkdir -p "$ZOO_LOG_DIR"; \
    chown "$ZOO_USER:$ZOO_USER" "$ZOO_LOG_DIR"

VOLUME ["$ZOO_DATA_DIR", "$ZOO_LOG_DIR"]

# Cleanup
RUN rm -rf /tmp/hdf_repos

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

