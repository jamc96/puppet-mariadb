# == Class: mariadb::install
#
class mariadb::install(
  String $repo_name  = $::mariadb::repo_name,
  String $baseurl    = $::mariadb::baseurl,
  String $descr      = $::mariadb::descr,
  String $enabled    = $::mariadb::enabled,
  String $gpgcheck   = $::mariadb::gpgcheck,
  String $gpgkey     = $::mariadb::gpgkey,
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
