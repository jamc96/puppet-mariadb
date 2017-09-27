# == Class: mariadb::install
#
class mariadb::install(
  String $repo_ensure      = $::mariadb::repo_ensure,
  String $repo_name        = $::mariadb::repo_name,
  String $baseurl          = $::mariadb::baseurl,
  String $descr            = $::mariadb::descr,
  String $enabled          = $::mariadb::enabled,
  String $gpgcheck         = $::mariadb::gpgcheck,
  String $gpgkey           = $::mariadb::gpgkey,
  String $package_name     = $::mariadb::package_name,
  String $package_ensure   = $::mariadb::package_ensure,
  String $package_provider = $::mariadb::package_provider,
) {
  # Adding repository
  yumrepo { $repo_name:
    ensure   => $repo_ensure,
    name     => $repo_name,
    baseurl  => $baseurl,
    descr    => $descr,
    enabled  => $enabled,
    gpgcheck => $gpgcheck,
    gpgkey   => $gpgkey,
    suscribe => Exec['clean_cache'],
  }
# Clean the yum cache
  exec { 'clean_cache':
    command     => 'yum clean metadata',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    timeout     => 0,
    refreshonly => true,
  }
# Intall MariaDB package
  package { $package_name:
    ensure   => $package_ensure,
    name     => $package_name,
    provider => $package_provider,
    require  => Exec['clean_cache'],
  }
}
