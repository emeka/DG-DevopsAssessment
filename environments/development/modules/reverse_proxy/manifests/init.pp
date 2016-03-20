class reverse_proxy {

  file { '/etc/yum.repos.d/nginx.repo':
    ensure => file,
    source => 'puppet:///modules/reverse_proxy/nginx.repo'
  }

  package { 'nginx':
    ensure  => present,
    require => File['/etc/yum.repos.d/nginx.repo']
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    backup => true,
    source => 'puppet:///modules/reverse_proxy/nginx.conf'
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => [Package['nginx'],File['/etc/nginx/conf.d/default.conf']]
  }
}
