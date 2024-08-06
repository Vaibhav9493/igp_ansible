#!/bin/bash

#######################################################################
# Get the Jenkins Variable for the script execution.
#######################################################################
dep_env=$1;
package_name=$2;

#######################################################################
# Clean old Repository.
#######################################################################
sudo rm -rvf /etc/yum.repos.d/igprepo*.repo;

#######################################################################
# Create new IGP Repository wrt Environment & Package
#######################################################################
if [ "$dep_env" == prod ];
then
sudo cat > /etc/yum.repos.d/igprepo-$dep_env-$package_name.repo << EOF
[igprepo-$dep_env-$package_name]
name=igprepo
baseurl=http://igprepo-prod.igp.local/igprepo/$dep_env/$package_name
enabled=1
gpgcheck=0
EOF

else
sudo cat > /etc/yum.repos.d/igprepo-$dep_env-$package_name.repo << EOF
[igprepo-$dep_env-$package_name]
name=igprepo
baseurl=http://igprepo-$dep_env.IGP-$dep_env.local/igprepo/$dep_env/$package_name
enabled=1
gpgcheck=0
EOF

fi