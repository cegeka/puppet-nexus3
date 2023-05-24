# Define: nexus3::config::blobstores
#
# Example in hiera:
#  nexus3::config::blobstores:
#    'blob01':
#      type:
#      path:
#      soft_quota_enabled:
#      quota_limit_bytes:
#      quota_type:
#
define nexus3::config::blobstores(
  $ensure = 'present',
  $type = undef,
  $path = undef,
  $soft_quota_enabled = undef,
  $quota_limit_bytes = undef,
  $quota_type = undef,
  $bucket = undef,
  $prefix = undef,
  $access_key_id = undef,
  $secret_access_key = undef,
  $session_token = undef,
  $assume_role = undef,
  $region = undef,
  $endpoint = undef,
  $expiration = undef,
  $signertype = undef,
  $forcepathstyle = undef
){

  nexus3_blobstore { $title:
    ensure             => $ensure,
    type               => $type,
    path               => $path,
    soft_quota_enabled => $soft_quota_enabled,
    quota_limit_bytes  => $quota_limit_bytes,
    quota_type         => $quota_type,
    bucket             => $bucket,
    prefix             => $prefix,
    access_key_id      => $access_key_id,
    secret_access_key  => $secret_access_key,
    session_token      => $session_token,
    assume_role        => $assume_role,
    region             => $region,
    endpoint           => $endpoint,
    expiration         => $expiration,
    signertype         => $signertype,
    forcepathstyle     => $forcepathstyle
  }

}
