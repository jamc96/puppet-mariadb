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
  Integer $version         = $mariadb::params::version,
  Float $release           = $mariadb::params::release,
  String $repo_ensure      = $mariadb::params::repo_ensure,
  String $repo_name        = $mariadb::params::repo_name,
  String $baseurl          = $mariadb::params::baseurl,
  String $descr            = $mariadb::params::descr,
  String $enabled          = $mariadb::params::enabled,
  String $gpgcheck         = $mariadb::params::gpgcheck,
  String $gpgkey           = $mariadb::params::gpgkey,
  String $package_name     = $mariadb::params::package_name,
  String $package_ensure   = $mariadb::params::package_ensure,
  String $package_provider = $mariadb::params::package_provider,
 ) inherits mariadb::params {

  class { '::mariadb::install': } ->
  Class['::mariadb']
}
