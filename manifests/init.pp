# Class: mariadb
# ===========================
#
# Full description of class mariadb here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'mariadb':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class mariadb(
  Optional[Pattern[/latest|^[.+_0-9:~-]+$/]] $version = undef,
  Pattern[/present|absent/] $package_ensure           = 'present',
  Pattern[/present|absent/] $config_ensure            = 'present',
  Pattern[/running|stopped/] $service_ensure          = 'running',
  String $config_file                                 = '/etc/my.cnf',
  String $service_name                                = 'mysql',
  ) {
  # global variables
  $use_version = $version ? {
    'latest' => '10.3.4',
    undef => '10.0.29',
    default => $version,
  }

  $public_repo = 'https://yum.mariadb.org'
  $os_name = $facts['operatingsystem'] ? {
    'RedHat' => 'rhel',
    default  => 'centos',
  }
  $baseurl = "${public_repo}/${use_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
  $gpgkey = "${public_repo}/RPM-GPG-KEY-MariaDB"
  $server_package_name = 'MariaDB-server'
  $client_package_name = 'MariaDB-client'
  $common_package_name = 'MariaDB-common'
  $compat_package_name = 'MariaDB-compat'
  # module containment
  contain ::mariadb::install
  contain ::mariadb::config
  contain ::mariadb::service
  # module relationship
  Class['::mariadb::install']
  -> Class['::mariadb::config']
  ~> Class['::mariadb::service']

}
