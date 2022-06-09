# Define: nexus3::config::privileges
#
# Example in hiera:
#  nexus3::config::privileges:
#    'role1':
#    role_id: 'roleID' # Should be the same as role_name
#    role_name: 'role1'
#    description: 'role1 description'
#    source: 'default'
#    roles:
#      - 'role2'
#      - 'role3'
#    privileges:
#     - privilege1
#     - privilege2

define nexus3::config::privileges (
  $ensure          = 'present',
  $privilege_name  = undef,
  $actions         = undef,
  $description     = undef,
  $format          = undef,
  $repository_name = undef,
  $type            = undef,
){

  nexus3_privilege { $privilege_name:
    ensure          => $ensure,
    actions         => $actions,
    description     => $description,
    format          => $format,
    repository_name => $repository_name,
    type            => $type,
  }
}

