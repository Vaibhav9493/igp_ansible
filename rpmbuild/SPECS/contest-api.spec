%define version %(cat ~/rpmversion)
%define package_name %(echo $package_name)
%define __os_install_post %{nil}
%define debug_package %{nil}

Name:           %{package_name}
Version:        %{version}
Release:        0
Summary:        %{package_name} package

Group:          %{package_name}_group
License:        IGP Fantasy Pvt. Ltd.
#URL:
Source0:        %{package_name}-%{version}.tar.gz
BuildArch:      noarch
BuildRoot:      /tmp/rpmbuildroot/
#BuildRequires:                                                                                                          1,1           Top


AutoReqProv: no
#Requires:

%description


%prep
%setup -q


%build


%install
mkdir -p $RPM_BUILD_ROOT/opt/apache-tomcat/webapps
cp -rp %{package_name}.war $RPM_BUILD_ROOT/opt/apache-tomcat/webapps/
cp -rp setenv.sh-* $RPM_BUILD_ROOT/opt/apache-tomcat/webapps/
cp -rp newrelic* $RPM_BUILD_ROOT/opt/apache-tomcat/webapps/
chmod -R 755 $RPM_BUILD_ROOT/opt/apache-tomcat/webapps/

%clean
rm -rf $RPM_BUILD_ROOT

%files
/opt/apache-tomcat/webapps/*


%changelog
