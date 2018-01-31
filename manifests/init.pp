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
  Optional[Integer] $version                = undef,
  Optional[Float] $release                  = undef,
  Pattern[/present|absent/] $package_ensure = 'present',
  Pattern[/present|absent/] $config_ensure  = 'present'
  ) inherits mariadb::params {
  # GLobal variables
  $use_version = $version ? {
    undef => $::mariadb::params::version,
    default => $version,
  }
  $use_release = $release ? {
    undef => $::mariadb::params::release,
    default => $release,
  }
  $use_package_ensure = $package_ensure ? {
    undef => $::mariadb::params::package_ensure,
    default => $package_ensure,
  }
  $use_config_ensure = $config_ensure ? {
    undef => $::mariadb::params::config_ensure,
    default => $config_ensure,
  }
  $use_repo_ensure = $use_package_ensure ? {
    'absent' => $use_package_ensure,
    default => $::mariadb::params::repo_ensure,
  }
  $public_repo  = downcase($::mariadb::params::public_repo)
  $full_version = "${use_version}.${use_release}"
  $os_name  = $mariadb::params::os_name
  # Validating release version
  if $use_release < $::mariadb::params::release_max {
      case $::operatingsystemmajrelease {
        '7': {
          $baseurl = "${public_repo}/${full_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
        }
        '6': {
          $baseurl = "${public_repo}/${full_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
        }
        default: {
          fail('OS Release version not supported on this module')
        }
      }
    } else{
      fail('MariaDB version is not supported')
    }

  class { '::mariadb::install': } -> Class['::mariadb']
}
