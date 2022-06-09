# Define: nexus3::config::cleanup_policies
#
# Example in hiera:
#  nexus3::config::cleanup_policies:
#    'cleanup_policy1':
#      format: 'apt'
#      notes: 'description'
#      is_prerelease: true
#      last_blob_updated: 7
#      last_downloaded: 14
#      regex: '.*deb'

define nexus3::config::cleanup_policies (
  $cleanup_policy_name = $title,
  $format              = undef,
  $notes               = undef,
  $is_prerelease       = undef,
  $last_blob_updated   = undef,
  $last_downloaded     = undef,
  $regex               = undef,
){

  nexus3_cleanup_policy { $cleanup_policy_name:
    format            => $format,
    notes             => $notes,
    is_prerelease     => $is_prerelease,
    last_blob_updated => $last_blob_updated,
    last_downloaded   => $last_downloaded,
    regex             => $regex,
  }
}
