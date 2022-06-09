# Define: nexus3::config::ldap
#
# Example in hiera:
#  nexus3::config::ldap:
#    'ldap_connection':
#      connection_name: 'ad.domain.tld'
#      hostname: 'server.ad.domain.tld'
#      search_base: 'dc=domain,dc=tld'
#      username: 'nexus3_serviceaccount'
#      password: 'nexus3_password'
#      ldap_filter: '(&(objectclass=user)(memberOf=CN=somegroup,DC=domain,DC=tld))'

define nexus3::config::ldap (
  $hostname                  = undef,
  $port                      = '636',
  $protocol                  = 'ldaps',
  $search_base               = undef,
  $authentication_scheme     = 'simple',
  $username                  = undef,
  $password                  = undef,
  $user_subtree              = 'true',
  $user_object_class         = 'user',
  $user_real_name_attribute  = 'cn',
  $user_email_attribute      = 'mail',
  $user_base_dn              = 'OU=users',
  $user_id_attribute         = 'cn',
  $user_password_attribute   = 'pw',
  $user_member_of_attribute  = '',
  $ldap_filter               = undef,
  $ldap_groups_as_roles      = 'false',
  $group_base_dn             = 'OU=groups',
  $group_subtree             = false,
  $group_object_class        = 'group',
  $group_member_format       = '${dn}',  # lint:ignore:single_quote_string_with_variables
  $group_member_attribute    = 'uniqueMember',
  $group_id_attribute        = 'cn',
) {

  nexus3_ldap { $title:
    hostname                  => $hostname,
    port                      => $port,
    protocol                  => $protocol,
    search_base               => $search_base,
    authentication_scheme     => $authentication_scheme,
    username                  => $username,
    password                  => $password,
    user_subtree              => $user_subtree,
    user_object_class         => $user_object_class,
    user_id_attribute         => $user_id_attribute,
    user_real_name_attribute  => $user_real_name_attribute,
    user_email_attribute      => $user_email_attribute,
    user_base_dn              => $user_base_dn,
    user_password_attribute   => $user_password_attribute,
    user_member_of_attribute  => $user_member_of_attribute,
    ldap_filter               => $ldap_filter,
    ldap_groups_as_roles      => $ldap_groups_as_roles,
    group_base_dn             => $group_base_dn,
    group_subtree             => $group_subtree,
    group_object_class        => $group_object_class,
    group_member_format       => $group_member_format,
    group_member_attribute    => $group_member_attribute,
    group_id_attribute        => $group_id_attribute
  }
}
