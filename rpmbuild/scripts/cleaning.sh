######################################################################
# Reading Version file.
######################################################################

version=$(cat ~/rpmversion-$JOB_NAME-$BUILD_NUMBER);

######################################################################
# Uploading the success package to AWS S3 (igprepo bucket)
######################################################################

aws s3 cp ~/rpmbuild/RPMS/noarch/$package_name-$version-0.noarch.rpm s3://igprepo/igprepo/$dep_env/$package_name/

######################################################################
# Cleaning the rpmbuild tree structure.
######################################################################

rm -vf ~/rpmbuild/SPECS/$package_name-$BUILD_NUMBER.spec;
rm -vf ~/rpmversion-$JOB_NAME-$BUILD_NUMBER;
rm -rf ~/rpmbuild/BUILD/*;
rm -rf ~/rpmbuild/BUILDROOT/*;
rm -rf ~/rpmbuild/RPMS/noarch/$package_name-$version-0.noarch.rpm;
rm -rf ~/rpmbuild/SRPMS/*;
rm -rf ~/rpmbuild/SOURCES/$package_name-$version;
rm -rf ~/rpmbuild/SOURCES/$package_name-$version.tar.gz;

