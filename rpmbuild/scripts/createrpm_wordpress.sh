######################################################################
# Create rpm from the source code.
######################################################################

#!/usr/bin/env bash
echo "CREATING RPM";

rpm_repo_server=$1;

######################################################################
# Check if directory structure present for rpm building.
######################################################################

if [ ! -d "~/rpmbuild" ]; then
echo "SETTING UP RPMBUILD TREE";
cd ~ ;
rpmdev-setuptree;
fi

######################################################################
# Create the Version file
#####################################################################
echo "CREATING VERSION FILE";

echo "$(date +'%s')_$GIT_COMMIT" > ~/rpmversion-$JOB_NAME-$BUILD_NUMBER;

version=$(cat ~/rpmversion-$JOB_NAME-$BUILD_NUMBER);
######################################################################
# Prepare source code for building.
######################################################################
echo "PREPARING SOURCE CODE TO BUILD";
mkdir -p ~/rpmbuild/SOURCES/$package_name-$version;
cp -rvp ~/workspace/$JOB_NAME/* ~/rpmbuild/SOURCES/$package_name-$version/;

rm -vrf ~/rpmbuild/SOURCES/$package_name-$version/$package_name/.git;
rm -vrf ~/rpmbuild/SOURCES/$package_name-$version/$package_name/.gitignore;

cd ~/rpmbuild/SOURCES;
tar cvzf $package_name-$version.tar.gz $package_name-$version;

######################################################################
# Prepare the SPEC file
######################################################################

echo "CREATING THE SPEC FILE";
cd ~/rpmbuild;
cp -vp /etc/ansible/rpmbuild/SPECS/$package_name.spec SPECS/$package_name-$BUILD_NUMBER.spec;
sed -i "s/rpmversion/rpmversion-$JOB_NAME-$BUILD_NUMBER/g" SPECS/$package_name-$BUILD_NUMBER.spec;

######################################################################
# Create the rpm package
######################################################################
echo "BUILDING THE RPM FROM SPEC";
rpmbuild -ba SPECS/$package_name-$BUILD_NUMBER.spec;

######################################################################
# Prepare and register package in RPM repository.
######################################################################
echo "COPING THE RPM TO THE REPOSITORY";
sudo ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/jenkins centos@$rpm_repo_server "if [ ! -d \"/data/igprepo/$dep_env/$package_name\" ]; then mkdir -p /data/igprepo/$dep_env/$package_name; fi;"

sudo scp -r -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/jenkins ~/rpmbuild/RPMS/noarch/$package_name-$version-0.noarch.rpm centos@$rpm_repo_server:/data/igprepo/$dep_env/$package_name/;

echo "REGISTERING THE RPM TO THE REPOSITORY";
sudo ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/jenkins centos@$rpm_repo_server "createrepo --update --cachedir=/tmp/$dep_env-rpmcache_$package_name --no-database --workers 4 /data/igprepo/$dep_env/$package_name";
