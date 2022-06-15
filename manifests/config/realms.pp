# Define: nexus3::config::realms
#
# Example in hiera:
#  nexus3::config::realms:
#   names:
#     - something
#
define nexus3::config::realms(
  $ensure          = 'present',
  $names           = []
){

  nexus3_realm_settings { $title :
    ensure => $ensure,
    names  => $names
  }
}
