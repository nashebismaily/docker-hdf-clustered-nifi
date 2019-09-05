#!/bin/bash

# Update Configs
sed -i -e "s/^nifi.registry.web.http.host=.*$/nifi.registry.web.http.host=$(hostname)/g" /etc/nifi-registry/conf/nifi-registry.properties
sed -i "/nifi.registry.db.directory=/c\nifi.registry.db.directory=$NIFI_REGISTRY_DATABASE_REPOSITORY" /etc/nifi-registry/conf/nifi-registry.properties
sed -i "/run.as=/c\run.as=$NIFI_REGISTRY_USER" /etc/nifi-registry/conf/nifi-registry.properties

# Install NiFi Registry
/usr/hdf/current/nifi-registry/bin/nifi-registry.sh install

# Update Permissions
chown -R $NIFI_REGISTRY_USER:$NIFI_REGISTRY_USER $NIFI_REGISTRY_CONF_DIR
HDF_VERSION=$(hdf-select versions | tail -1 | tr -d ' ')
chown -R $NIFI_REGISTRY_USER:$NIFI_REGISTRY_USER /usr/hdf/$HDF_VERSION/nifi-registry

# Start NiFi Registry
service nifi-registry start

# Keep Container Running
tail -f /dev/null

