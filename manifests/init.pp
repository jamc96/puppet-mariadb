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
  Optional[Integer] $version         = undef,
  Optional[Float] $release           = undef,
  Optional[String] $repo_ensure      = undef,
  Optional[String] $repo_name        = undef,
  Optional[String] $descr            = undef,
  Optional[String] $enabled          = undef,
  Optional[String] $gpgcheck         = undef,
  Optional[String] $gpgkey           = undef,
  Optional[String] $package_name     = undef,
  Optional[String] $package_ensure   = undef,
  Optional[String] $package_provider = undef,
  Optional[String] $public_repo      = undef,
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
  $use_repo_ensure = $repo_ensure ? {
    undef => $::mariadb::params::repo_ensure,
    default => $repo_ensure,
  }
  $use_repo_name = $repo_name ? {
    undef => $::mariadb::params::repo_name,
    default => $repo_name,
  }
  $use_descr = $descr ? {
    undef => $::mariadb::params::descr,
    default => $descr,
  }
  $use_enabled = $enabled ? {
    undef => $::mariadb::params::enabled,
    default => $enabled,
  }
  $use_gpgcheck = $gpgcheck ? {
    undef => $::mariadb::params::gpgcheck,
    default => $gpgcheck,
  }
  $use_gpgkey = $gpgkey ? {
    undef => $::mariadb::params::gpgkey,
    default => $gpgkey,
  }
  $use_package_name = $package_name ? {
    undef => $::mariadb::params::package_name,
    default => $package_name,
  }
  $use_package_ensure = $package_ensure ? {
    undef => $::mariadb::params::package_ensure,
    default => $package_ensure,
  }
  $use_package_provider = $package_provider ? {
    undef => $::mariadb::params::package_provider,
    default => $package_provider,
  }
  $use_public_repo = $public_repo ? {
    undef => $::mariadb::params::public_repo,
    default => $public_repo,
  }

  $full_version = "${use_version}.${use_release}"
  $os_name  = $mariadb::params::os_name
  # Validating release version
  if $use_release < $::mariadb::params::release_max {
      case $::operatingsystemmajrelease {
        '7': {
          $baseurl = "${use_public_repo}/${full_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
        }
        '6': {
          $baseurl = "${use_public_repo}/${full_version}/${os_name}/${::operatingsystemmajrelease}/${::architecture}/"
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
