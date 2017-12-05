class mariadb::params {
  $version          = 10
  $release          = 0.29
  $repo_ensure      = 'present'
  $repo_name        = 'mariadb'
  $descr            = 'MariaDB'
  $enabled          = '1'
  $gpgcheck         = '1'
  $public_repo      = 'https://yum.mariadb.org'
  $gpgkey           = "${public_repo}/RPM-GPG-KEY-MariaDB"
  $version_max      = 10
  $release_max      = 3.1
  $full_version     = "${version}.${release}"
  $package_name     = 'MariaDB'
  $package_ensure   = 'present'
  $package_provider = 'yum'

  $os_name = $facts['operatingsystem'] ? {
    'RedHat' => 'rhel',
    default  => 'centos',
  }
}
