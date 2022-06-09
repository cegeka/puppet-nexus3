# Class: nexus3::params
#
# This is a private class and should not be called directly
#
class nexus3::params (
  $service_enable = true,
  $service_ensure = 'running',
  $service_manage = true,
  $service_name = 'nexus',
  $package_ensure = 'present',
  $package_name = 'nexus3-oss',
  $work_dir = '/opt/sonatype-work',
  $context_path = 'nexus',
  $anonymous = false,
) {

}
