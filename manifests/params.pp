# == Class: mariadb::params
#
class mariadb::params {
  $version          = '10.0.29'
  $latest_version   = '10.3.4'
  $repo_ensure      = 'present'
  $repo_name        = 'mariadb'
  $descr            = 'MariaDB'
  $enabled          = '1'
  $gpgcheck         = '1'
  $public_repo      = 'https://yum.mariadb.org'
  $gpgkey           = "${public_repo}/RPM-GPG-KEY-MariaDB"
  $package_name     = 'MariaDB'
  $package_ensure   = 'present'
  $package_provider = 'yum'
  $config_ensure    = 'present'
  $config_path      = '/etc/my.cnf'
  $config_owner     = 'mysql'
  $config_group     = 'mysql'

  $os_name = $facts['operatingsystem'] ? {
    'RedHat' => 'rhel',
    default  => 'centos',
  }
}
