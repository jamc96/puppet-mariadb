# == Class: mariadb::config
#
class mariadb::config(
  $config_ensure = $::mariadb::use_config_ensure,
  $config_path   = $::mariadb::params::config_path,
  $config_owner  = $::mariadb::params::config_owner,
  $config_group  = $::mariadb::params::config_group,
) inherits mariadb::params {
  #Mysql Config File
  file { 'mysql_config':
    ensure => $config_ensure,
    path   => $config_path,
    owner  => $config_owner,
    group  => $config_group,
  }
}
