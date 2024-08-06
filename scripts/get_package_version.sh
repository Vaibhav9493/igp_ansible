#!/bin/bash

#######################################################################
# Get the Jenkins Variable for the script execution.
#######################################################################
BUILD_NUMBER=$1;
package_name=$2;

#######################################################################
# Get the Latest Package Version from the Repository
#######################################################################
sudo yum clean all;
version_latest=$(sudo yum list $package_name | tail -1 | tr -s ' '|cut -d' ' -f 2);
echo "version_required=$version_latest" | tee /tmp/version-$package_name-$BUILD_NUMBER;
sudo chmod 755 /tmp/version-$package_name-$BUILD_NUMBER;
