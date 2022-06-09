# Class: nexus3::config
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
class nexus3::config(
  $work_dir   = $nexus3::work_dir,
) inherits nexus3 {

  file { [
    $nexus3::work_dir,
    "${nexus3::work_dir}/nexus3",
    "${nexus3::work_dir}/nexus3/etc"
    ]:
    ensure => directory,
    mode   => '0751',
    owner  => 'nexus',
    group  => 'nexus',
  }

  file { "${nexus3::work_dir}/nexus3/etc/nexus.properties":
    ensure  => file,
    mode    => '0640',
    owner   => 'nexus',
    group   => 'nexus',
    content => template("${module_name}/nexus.properties.erb"),
    notify  => Service[$nexus3::service_name],
    require => File["${nexus3::params::work_dir}/nexus3/etc"]
  }

  file { "${settings::confdir}/nexus3_rest.conf":
    ensure  => file,
    mode    => '0600',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/nexus3_rest.conf.erb")
  }

}
