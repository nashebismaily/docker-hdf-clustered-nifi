# docker-hdf-clustered-nifi
Cluster HDF 3.1.1 NiFi with Zookeeper. Also deploys NiFi Registry.

# Setup

There are 3 base directories which controll the container deployments: nifi-base, nifi-registry-base, zookeeper-base.
Each of these contains a subdirectory called hdf-repos

Download the HDF RPM release here:
http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.1.1.0/HDF-3.1.1.0-centos7-rpm.tar.gz

This link can be found on the Hortonworks release notes:
https://docs.hortonworks.com/HDPDocuments/HDF3/HDF-3.1.1/bk_release-notes/content/ch_hdf_relnotes.html

Copy the hdf-select-3.1.1.0-35.noarch.rpm RPM into the hdf_repos directory under all 3: nifi-base, nifi-registry-base, zookeeper-base

Copy the zookeeper_3_1_1_0_35-3.4.6.3.1.1.0-35.noarch.rpm and zookeeper_3_1_1_0_35-server-3.4.6.3.1.1.0-35.noarch.rpm into the hdf_repos directory under zookeeper-base

Copy the nifi_3_1_1_0_35-1.5.0.3.1.1.0-35.x86_64.rpm into the hdf_repos directory under nifi-base

Copy the nifi-registry_3_1_1_0_35-0.1.0.3.1.1.0-35.noarch.rpm into the hdf_repos directory under nifi-registry-base
  
# Run

docker-compose up -d

