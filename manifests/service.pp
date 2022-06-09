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
class nexus3::service (
  $service_enable = $::nexus3::service_enable,
  $service_ensure = $::nexus3::service_ensure,
  $service_manage = $::nexus3::service_manage,
  $service_name   = $::nexus3::service_name,
) inherits nexus3 {
  if !($service_ensure in ['running', 'stopped']) {
    fail('service_ensure parameter must be running or stopped')
  }

  if $service_manage == true {
    service { $service_name:
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
