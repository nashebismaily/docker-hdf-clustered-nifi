#!/bin/bash

# Update the config
CONFIG="$ZOO_CONF_DIR/zoo.cfg"

sed -i "/tickTime/c\tickTime=$ZOO_TICK_TIME" $CONFIG
sed -i "/initLimit/c\initLimit=$ZOO_INIT_LIMIT" $CONFIG
sed -i "/syncLimit/c\syncLimit=$ZOO_SYNC_LIMIT" $CONFIG
sed -i "/dataDir/c\dataDir=$ZOO_DATA_DIR" $CONFIG
sed -i "/clientPort/c\clientPort=$ZOO_PORT" $CONFIG

for server in $ZOO_SERVERS; do
    echo "$server" >> "$CONFIG"
done

# Update log4j
sed -i "/zookeeper.log.dir=/c\zookeeper.log.dir=$ZOO_LOG_DIR" $ZOO_CONF_DIR/log4j.properties

# Update zkServer enviornemnt
HDF_VERSION=$(hdf-select versions | tail -1 | tr -d ' ')
sed -i "/ZOO_LOG_DIR=/c\ZOO_LOG_DIR=$ZOO_LOG_DIR" /usr/hdf/current/zookeeper-server/bin/zkEnv.sh

# Write myid
echo "${ZOO_MY_ID:-1}" > "$ZOO_DATA_DIR/myid"

# Update Permissions on config directory and myid
chown -R $ZOO_USER:$ZOO_USER $ZOO_CONF_DIR
chown -R $ZOO_USER:$ZOO_USER $ZOO_DATA_DIR
chown -R $ZOO_USER:$ZOO_USER $ZOO_LOG_DIR
chown -R $ZOO_USER:$ZOO_USER /usr/hdf/$HDF_VERSION/zookeeper

# Cleanup
rm -rf /usr/hdf/$HDF_VERSION/etc

# Start Zookeeper
su - $ZOO_USER -c "zookeeper-server start-foreground"


