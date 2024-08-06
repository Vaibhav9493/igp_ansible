# Scripts to help CI/CD with Jenkins for some custom tasks.

find_latest_package.sh: Find the latest package in igprepo(rpm repository). To be used with Jenkins.

get_package_version.sh: Get the latest package version of the RPM available in the repository using YUM. To be used with Jenkins.

rename-instances.sh: Rename the instances in serial number under the same cluster.

#./rename-instances.sh cluster_name instance_base_name

rpmrepo_check.sh: Ensures the required repository config is present to the instance for the deployment.

uat_approve.sh: Core for the UAT Approve job that execute before the final production deployment.

uat_reject.sh : Vice versa for the UAT approve job. If the UAT is unsuccessful we need job with this core.