# Class: nexus3::service
#
# This module manages nexus3
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class nexus3::package (
  $package_ensure = $nexus3::package_ensure,
  $package_name   = $nexus3::package_name,
) inherits nexus3 {

  package { $package_name :
    ensure => $package_ensure,
  }

}
