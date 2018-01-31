# == Class: mariadb::install
#
class mariadb::install(
  String $baseurl          = $::mariadb::baseurl,
  String $repo_ensure      = $::mariadb::use_repo_ensure,
  String $package_ensure   = $::mariadb::use_package_ensure,
  String $repo_name        = $::mariadb::params::repo_name,
  String $descr            = $::mariadb::params::descr,
  String $enabled          = $::mariadb::params::enabled,
  String $gpgcheck         = $::mariadb::params::gpgcheck,
  String $gpgkey           = $::mariadb::params::gpgkey,
  String $package_name     = $::mariadb::params::package_name,
  String $package_provider = $::mariadb::params::package_provider,
) inherits mariadb::params {
  # Adding repository
  yumrepo { $repo_name:
    ensure   => $repo_ensure,
    name     => $repo_name,
    baseurl  => $baseurl,
    descr    => $descr,
    enabled  => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey   => $gpgkey,
  }
# Clean the yum cache
  exec { 'clean_cache':
    command     => 'yum clean metadata',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    timeout     => 0,
    refreshonly => true,
    require     => Yumrepo[$repo_name],
  }
# Intall MariaDB package
  package { $package_name:
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
    require  => Exec['clean_cache'],
  }
}
