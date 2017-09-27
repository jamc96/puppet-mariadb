# == Class: mariadb::para
#
class mariadb::params {
  $version     = 10.0
  $repo_ensure = 'present'
  $repo_name   = 'mariadb'
  $descr       = 'MariaDB'
  $enabled     = '1'
  $gpgcheck    = '1'
  $gpgkey      = 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'
  $version_max = 10.3
  if $version <  $version_max{
    case $operatingsystemmajrelease {
      '7': {
        $baseurl = "http://yum.mariadb.org/${version}/downcase(${operatingsystem})/7/x86_64/"
      }
      '6': {
        $baseurl = "http://yum.mariadb.org/${version}/downcase(${operatingsystem})/6/x86_64/"
      }
      default: {
        fail('OS Release version not supported on this module')
      }
    }
  }else {
    fail('MariaDB version is not supported')
  }

}
