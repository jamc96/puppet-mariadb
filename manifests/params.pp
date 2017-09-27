class mariadb::params {
  $version      = 10
  $release      = 0.29
  $repo_ensure  = 'present'
  $repo_name    = 'mariadb'
  $descr        = 'MariaDB'
  $enabled      = '1'
  $gpgcheck     = '1'
  $gpgkey       = 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'
  $os_name      = downcase(facts['operatingsystem'])
  $full_version = "${version}${release}"

  case $release {
    '/[1-3]/': {
      case facts['operatingsystemmajrelease'] {
        '7': {
          $baseurl = "http://yum.mariadb.org/${full_version}/${os_name}/7/x86_64/"
        }
        '6': {
          $baseurl = "http://yum.mariadb.org/${full_version}/${os_name}/6/x86_64/"
        }
        default: {
          fail('OS Release version not supported on this module')
        }
      }
    }
    default: {
      fail('MariaDB version is not supported')
    }
  }
}
