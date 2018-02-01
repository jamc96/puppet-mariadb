# mariadb::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mariadb::service
class mariadb::service(
  $service_ensure     = $mariadb::use_service_ensure,
  $service_name       = $mariadb::params::service_name,
  $service_hasrestart = $mariadb::params::service_hasrestart,
  $service_hasstatus  = $mariadb::params::service_hasstatus,
  $service_enable     = $mariadb::params::service_enable,
) {
  service { 'mysql_service':
    ensure     => $service_ensure,
    name       => $service_name,
    hasrestart => $service_hasrestart,
    hasstatus  => $service_hasstatus,
    enable     => $service_enable,
  }
}
