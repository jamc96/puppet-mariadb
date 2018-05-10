# mariadb::service
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mariadb::service
class mariadb::service {
# creating mariadb service
service { $::mariadb::service_name:
    ensure     => $::mariadb::service_ensure,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
