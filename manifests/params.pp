class mariadb::params {
  $version      = 10
  $release      = 0.29
  $repo_ensure  = 'present'
  $repo_name    = 'mariadb'
  $descr        = 'MariaDB'
  $enabled      = '1'
  $gpgcheck     = '1'
  $gpgkey       = 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB'
  $os_name      = downcase($operatingsystem)
  $version_max  = 10
  $release_max  = 3.1
  $full_version = "${version}${release}"

  if $release < $release_max {
      case $operatingsystemmajrelease {
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
    } else{
      fail('MariaDB version is not supported')
    }
  }
