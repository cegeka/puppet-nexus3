# Class: nexus3
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
class nexus3(
  $admin_password,
  $service_enable          = $::nexus3::params::service_enable,
  $service_ensure          = $::nexus3::params::service_ensure,
  $service_manage          = $::nexus3::params::service_manage,
  $service_name            = $::nexus3::params::service_name,
  $package_ensure          = $::nexus3::params::package_ensure,
  $package_name            = $::nexus3::params::package_name,
  $work_dir                = $::nexus3::params::work_dir,
  $context_path            = $::nexus3::params::context_path,
  $anonymous               = $::nexus3::params::anonymous,
  $can_delete_repositories = $::nexus3::params::can_delete_repositories
  ) inherits nexus3::params {

  contain nexus3::package
  contain nexus3::config
  contain nexus3::service
  contain nexus3::post

  Class['nexus3::package'] ~> Class['nexus3::config'] ~> Class['nexus3::service'] ~> Class['nexus3::post']

}
