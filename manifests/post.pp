# Class: nexus3::post
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
class nexus3::post(
  $admin_password = $nexus3::admin_password,
  $anonymous = $nexus3::anonymous
) inherits nexus3 {

  nexus3_admin_password { 'admin_password':
    admin_password_file => "${nexus3::work_dir}/nexus3/admin.password",
    password            => $admin_password
  }

  nexus3_anonymous_settings { 'global':
    enabled => $anonymous,
    require => Nexus3_admin_password['admin_password']
  }

}
