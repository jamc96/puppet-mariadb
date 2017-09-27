# == Class: mariadb::para
#
class mariadb::params {
  $version    = 10.0
  $repo_name  = 'mariadb.repo'
  $descr      = 'File Managed by Puppet'
  $enabled    = '1'
  $gpgcheck   = '1'
  $gpgkey     = "puppet::///${module_name}/RPM-GPG-KEY-MariaDB"

  if $version < 10.3 {
    case facts['operatingsystemmajrelease'] {
      '7': {
        $baseurl = "http://yum.mariadb.org/${version}/${operatingsystem}/7"
      }
      '6': {
        $baseurl = "http://yum.mariadb.org/${version}/${operatingsystem}/6"
      }
      default: {
        fail('OS Release version not supported on this module')
      }
    }
  }else {
    fail('MariaDB version is not supported')
  }

}
