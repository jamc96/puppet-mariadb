# == Class: mariadb::install
#
class mariadb::install(
  $repo_name  = $::mariadb::repo_name,
  $baseurl    = $::mariadb::baseurl,
  $descr      = $::mariadb::descr,
  $enabled    = $::mariadb::enabled,
  $gpgcheck   = $::mariadb::gpgcheck,
  $gpgkey     = $::mariadb::gpgkey,
) {
  # Adding repository
  yumrepo { $repo_name:
    baseurl  => $baseurl,
    descr    => $descr,
    enabled  => $enabled,
    gpgcheck => $gpgkey,
    gpgkey   => $gpgkey,
  }
}
