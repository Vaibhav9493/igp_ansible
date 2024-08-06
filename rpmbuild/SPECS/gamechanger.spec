
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
#BuildRequires:                                                                                      


AutoReqProv: no
#Requires:

%description


%prep
%setup -q


%build


%install
mkdir -p $RPM_BUILD_ROOT/var/www/html/%{package_name}
cp -rp * $RPM_BUILD_ROOT/var/www/html/%{package_name}


%clean
sudo rm -rf $RPM_BUILD_ROOT

%post 
chmod -R 755 /var/www/html/%{package_name}
sudo chown -R apache:apache /var/www/html/%{package_name}

%files
/var/www/html/%{package_name}/*


%changelog
