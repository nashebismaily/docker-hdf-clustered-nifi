#!/bin/bash

# Update Configs
sed -i -e "s/^nifi.web.http.host=.*$/nifi.web.http.host=$(hostname)/g" /etc/nifi/conf/nifi.properties
sed -i -e "s/^nifi.cluster.node.address=.*$/nifi.cluster.node.address=$(hostname)/g" /etc/nifi/conf/nifi.properties
sed -i -e "s/^nifi.remote.input.host=.*$/nifi.remote.input.host=$(hostname)/g" /etc/nifi/conf/nifi.properties

sed -i "/nifi.database.directory=/c\nifi.database.directory=$NIFI_DATABASE_REPOSITORY" /etc/nifi/conf/nifi.properties
sed -i "/nifi.flowfile.repository.directory=/c\nifi.flowfile.repository.directory=$NIFI_FLOWFILE_REPOSITORY" /etc/nifi/conf/nifi.properties
sed -i "/nifi.content.repository.directory.default=/c\nifi.content.repository.directory.default=$NIFI_CONTENT_REPOSITORY" /etc/nifi/conf/nifi.properties
sed -i "/nifi.provenance.repository.directory.default=/c\nifi.provenance.repository.directory.default=$NIFI_PROVENANCE_REPOSITORY" /etc/nifi/conf/nifi.properties

sed -i "/run.as=/c\run.as=$NIFI_USER" /etc/nifi/conf/nifi.properties

# Install NiFi
/usr/hdf/current/nifi/bin/nifi.sh install

# Update Permissions
chown -R $NIFI_USER:$NIFI_USER $NIFI_CONF_DIR
HDF_VERSION=$(hdf-select versions | tail -1 | tr -d ' ')
chown -R $NIFI_USER:$NIFI_USER /usr/hdf/$HDF_VERSION/nifi

# Start NiFi
service nifi start

# Keep NiFi Running
tail -f $NIFI_LOG_DIR/nifi-app.log

