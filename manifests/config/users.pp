# Define: nexus3::config::users
#
# Example in hiera:
#  nexus3::config::users:
#   'johndoe':
#     username: 'johndoe'
#     firstname: 'John'
#     lastname: 'Doe'
#     password_id: 123456
#     email: 'john.doe@cegeka.com'
#     roles:
#      - 'role1'
#      - 'role2'

define nexus3::config::users (
  $username    = undef,
  $firstname   = undef,
  $lastname    = undef,
  $email       = undef,
  $read_only   = 'false',
  $roles       = undef,
  $status      = 'active',
  $password    = undef,
){

  nexus3_user { $username:
    firstname => $firstname,
    lastname  => $lastname,
    password  => $password,
    email     => $email,
    read_only => $read_only,
    roles     => $roles,
    status    => $status,
  }
}
