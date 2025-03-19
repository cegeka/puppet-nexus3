# Define: nexus3::config::repository_groups
#
# Example in hiera:
#  nexus3::config::repository_groups:
#    'repo_group1':
#      repository_group_name: 'repo_group1'
#      provider_type: 'maven2'
#      repositories:
#       - 'repo1'
#       - 'repo2'
#      custom_ssl_cert: '<absolute_path_to_cert>.crt'
#      custom_ssl_key: '<absolute_path_to_key>.key'
#
# Make sure to also create the actual cert/key files, for example:
# profile::iac::common::files::list:
#   '<absolute_path_to_cert>.crt':
#    ensure: present
#    content: "%{lookup('thycotic::lookup::<pim_id>::certificate')}"
#    mode: '0400'
#    notify: Service[nginx]
define nexus3::config::repository_groups (
  $repository_group_name            = undef,
  $provider_type                    = undef,
  $online                           = 'true',
  $blobstore_name                   = undef,
  $strict_content_type_validation   = 'true',
  $repositories                     = undef,
  $http_port                        = undef,
  $force_basic_auth                 = undef,
  $v1_enabled                       = undef,
  $custom_ssl_key                   = undef,
  $custom_ssl_cert                  = undef,
) {
  if !$repository_group_name {
    $real_repository_group_name = $title
  } else {
    $real_repository_group_name = $repository_group_name
  }

  if $provider_type == 'docker' and $http_port {
    profile::iac::nginx::vhost { $real_repository_group_name:
      location_custom_cfg => {
        return => "301 https://${$real_repository_group_name}",
      }
    }

    $ssl_cert = $custom_ssl_cert ? { undef => '/etc/ssl/certs/nexus3.crt', default => $custom_ssl_cert }
    $ssl_key  = $custom_ssl_key ? { undef => '/etc/ssl/certs/nexus3.key', default => $custom_ssl_key }

    profile::iac::nginx::vhostssl { $real_repository_group_name:
      client_max_body_size => '2g',
      ssl_cert             => $ssl_cert,
      ssl_key              => $ssl_key,
      locations            => {
        "upstream_${real_repository_group_name}_443" => {
          location              => '~ "/"',
          proxy                 => "http://upstream_${real_repository_group_name}",
          proxy_set_header      => [
            'X-Real-IP $remote_addr',
            'Host $host',
            'X-Forwarded-For $proxy_add_x_forwarded_for',
            'X-Forwarded-Proto "https"',
          ],
          proxy_redirect        => 'default',
          proxy_read_timeout    => '300',
          proxy_send_timeout    => '120',
          proxy_connect_timeout => '90',
          proxy_http_version    => '1.1',
          proxy_buffering       => 'off',
        },
      },
    }

    nginx::resource::upstream { "upstream_${real_repository_group_name}":
      ensure  => present,
      members => {
        "localhost:${http_port}" => {
          server => 'localhost',
          port   => Integer($http_port),
        }
      }
    }
  }

  nexus3_repository_group { $real_repository_group_name:
    provider_type                  => $provider_type,
    online                         => $online,
    blobstore_name                 => $blobstore_name,    #optional
    strict_content_type_validation => $strict_content_type_validation,
    repositories                   => $repositories,
    http_port                      => $http_port,
    force_basic_auth               => $force_basic_auth,
    v1_enabled                     => $v1_enabled
  }
}
