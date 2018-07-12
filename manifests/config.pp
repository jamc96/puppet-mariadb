# == Class: mariadb::config
#
class mariadb::config inherits mariadb {
  # create mariadb config file
  file { $mariadb::config_file:
    ensure => $mariadb::config_ensure,
    mode   => '0774',
    owner  => 'mysql',
    group  => 'mysql',
  }
}
