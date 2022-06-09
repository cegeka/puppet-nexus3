# Define: nexus3::config::roles
#
# Example in hiera:
# nexus3::config::roles
#   'YOUR-GROUP-Admin':
#     role_id: 'YOUR-GROUP--Admin'
#     role_name: 'YOUR-GROUP--Admin'
#     description: 'Admin role for YOUR-GROUP'
#     privileges:
#       - 'nx-all'

define nexus3::config::roles (
  $role_id     = undef,
  $role_name   = undef,
  $description = undef,  #optional
  $roles       = undef,
  $privileges  = undef,
  $read_only   = undef,
  $source      = undef,
){

  nexus3_role { $role_id:
    role_name   => $role_name,
    description => $description,  #optional
    roles       => $roles,
    privileges  => $privileges,
    read_only   => $read_only,
    source      => $source,
  }
}
