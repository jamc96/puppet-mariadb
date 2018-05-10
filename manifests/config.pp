# == Class: mariadb::config
#
class mariadb::config {
  # create mariadb config file
  file { $mariadb::config_file:
    ensure => $mariadb::config_ensure,
    path   => $mariadb::config_file,
    mode   => '0644',
    owner  => 'mysql',
    group  => 'mysql',
  }
}
