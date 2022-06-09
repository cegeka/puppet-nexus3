# Define: nexus3::config::repositories
#
# Example in hiera:
#  nexus3::config::repositories:
#    'repo1':
#      repository_name: 'repo1'
#      type: 'hosted'
#      provider_type: 'apt'
#      cleanup_policies:
#        - 'cleanup1'
#        - 'cleanup2'

define nexus3::config::repositories (
  $repository_name                 = undef,
  $type                            = undef,
  $provider_type                   = undef,
  $online                          = 'true',
  $blobstore_name                  = undef,
  $cleanup_policies                = undef,
  $version_policy                  = undef,
  $write_policy                    = undef,
  $strict_content_type_validation  = 'true',
  $auto_block                      = undef,
  $blocked                         = undef,
  $remote_url                      = undef,
  $remote_auth_type                = undef,
  $remote_user                     = undef,
  $remote_password                 = undef,
  $remote_ntlm_host                = undef,
  $remote_ntlm_domain              = undef,
  $depth                           = undef,
  $routing_rule                    = undef,
  $layout_policy                   = undef, #maven2 specific
  $http_port                       = undef, #docker specific
  $https_port                      = undef, #docker specific
  $force_basic_auth                = undef, #docker specific
  $v1_enabled                      = undef, #docker specific
  $index_type                      = undef,
  $create_nginx_config             = true
){

  if ! $repository_name {
    $real_repository_name = $title
  }else{
    $real_repository_name = $repository_name
  }

  if $provider_type == 'docker' and $type != 'proxy' and $http_port and $create_nginx_config {
    profile::iac::nginx::vhost { $real_repository_name:
      location_custom_cfg => {
        return => "301 https://${$real_repository_name}",
      }
    }

    profile::iac::nginx::vhostssl { $real_repository_name:
      client_max_body_size => '2g',
      ssl_cert             => '/etc/ssl/certs/nexus3.crt',
      ssl_key              => '/etc/ssl/certs/nexus3.key',
      locations            => {
        "upstream_${real_repository_name}_443" => {
          location              => '~ "/"',
          proxy                 => "http://upstream_${real_repository_name}",
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
        }
      }
    }

    nginx::resource::upstream { "upstream_${real_repository_name}":
      ensure  => present,
      members => {
        "localhost:${http_port}" => {
          server => 'localhost',
          port   => Integer($http_port),
        }
      }
    }
  }

  nexus3_repository { $real_repository_name:
    type                           => $type,
    provider_type                  => $provider_type,
    online                         => $online,
    blobstore_name                 => $blobstore_name,            #optional
    cleanup_policies               => $cleanup_policies,
    version_policy                 => $version_policy,
    write_policy                   => $write_policy,
    strict_content_type_validation => $strict_content_type_validation,
    auto_block                     => $auto_block,                #optional
    blocked                        => $blocked,                   #optional
    remote_url                     => $remote_url,
    remote_auth_type               => $remote_auth_type,
    remote_user                    => $remote_user,               #optional
    remote_password                => $remote_password,           #optional
    remote_ntlm_host               => $remote_ntlm_host,          #optional
    remote_ntlm_domain             => $remote_ntlm_domain,        #optional
    depth                          => $depth,                     #optional
    routing_rule                   => $routing_rule,              #optional
    layout_policy                  => $layout_policy,
    http_port                      => $http_port,
    https_port                     => $https_port,
    force_basic_auth               => $force_basic_auth,
    v1_enabled                     => $v1_enabled,
    index_type                     => $index_type
  }
}
