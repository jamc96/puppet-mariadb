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
  Pattern[/present|absent/] $package_ensure = 'present',
  Pattern[/present|absent/] $config_ensure  = 'present'
  ) inherits mariadb::params {
  # GLobal variables
  $use_version = $version ? {
    'latest' => $::mariadb::parameter::latest_version,
    undef => $::mariadb::params::version,
    default => $version,
  }
  $use_package_ensure = $package_ensure ? {
    'present' => $::mariadb::params::package_ensure,
    default => $package_ensure,
  }
  $use_repo_ensure = $package_ensure ? {
    'absent' => $package_ensure,
    default => $::mariadb::params::repo_ensure,
  }
  $use_config_ensure = $config_ensure ? {
    'present' => $::mariadb::params::config_ensure,
    default => $config_ensure,
  }
  $public_repo  = $::mariadb::params::public_repo
  $os_name  = $mariadb::params::os_name
  # Validating release version
  $baseurl = "${public_repo}/${use_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"

  class { '::mariadb::install': } -> class { '::mariadb::config': } -> Class['::mariadb']
}
