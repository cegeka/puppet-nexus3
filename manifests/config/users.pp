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
  $username    = $title,
  $firstname   = undef,
  $lastname    = undef,
  $email       = undef,
  $roles       = undef,
  $status      = 'active',
  $password    = undef,
){

  nexus3_user { $username:
    firstname => $firstname,
    lastname  => $lastname,
    password  => $password,
    email     => $email,
    roles     => $roles,
    status    => $status,
  }
}
