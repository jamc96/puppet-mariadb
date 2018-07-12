# == Class: mariadb::install
#
class mariadb::install inherits mariadb {
  # install mariadb respository
  yumrepo { 'mariadb':
    ensure   => 'present',
    name     => 'mariadb',
    baseurl  => $::mariadb::baseurl,
    descr    => 'MariaDB',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => $::mariadb::gpgkey,
  }
  # install all mariadb packages
  Package {
    ensure   => $mariadb::package_ensure,
    provider => 'yum',
  }
  # install all mariadb packages
  package {
    $::mariadb::common_package_name:
      require => Yumrepo['mariadb'];
    $::mariadb::compat_package_name:
      require => Package[$::mariadb::common_package_name];
    $::mariadb::client_package_name:
      require => Package[$::mariadb::compat_package_name];
    $::mariadb::server_package_name:
      require => Package[$::mariadb::client_package_name];
  }
}
