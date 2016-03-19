class demo_app {

  file { '/etc/yum.repos.d/nginx.repo':
    ensure => file,
    source => 'puppet:///modules/demo_app/nginx.repo'
  }

  package { 'java':
    ensure => present
  }

  package { 'mariadb':
    ensure => present
  }

  package { 'mariadb-server':
    ensure => present
  }

  package { 'nginx':
    ensure  => present,
    require => File['/etc/yum.repos.d/nginx.repo']
  }

  file { '/etc/default/demo':
    ensure  => file,
    source  => 'puppet:///modules/demo_app/demo.environment',
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }
  
  file { '/usr/local/lib/demo':
    ensure => directory
  }

  file { '/usr/local/lib/demo/demo.war':
    ensure  => file,
    source  => 'puppet:///modules/demo_app/demo.war',
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }

  file { '/usr/local/lib/demo/data.sql':
    ensure  => file,
    source  => 'puppet:///modules/demo_app/data.sql',
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }

  file { '/usr/lib/systemd/system/demo.service':
    ensure => file,
    source => 'puppet:///modules/demo_app/demo.service',
    mode   => '0644',
    owner  => 'root',
    group  => 'root'
  }

  service { 'demo':
    ensure => running,
    enable => true,
    require => Package['java'],
    subscribe => File[
        '/usr/local/lib/demo/demo.war',
        '/usr/lib/systemd/system/demo.service',
        '/etc/default/demo']
  }

  file { '/usr/local/lib/demo/healthcheck.sh':
    ensure  => file,
    source  => 'puppet:///modules/demo_app/healthcheck.sh',
    mode    => '0755',
    owner   => 'root',
    group   => 'root'
  }

  file { '/usr/lib/systemd/system/healthcheck.service':
    ensure => file,
    source => 'puppet:///modules/demo_app/healthcheck.service',
    mode => '0644',
    owner => 'root',
    group => 'root'
  }

  service { 'healthcheck':
    ensure => running,
    enable => true,
    subscribe => File['/usr/lib/systemd/system/healthcheck.service']
  }

  service { 'mariadb':
    ensure => running,
    enable => true,
    require => Package['mariadb-server']
  }

  exec { 'init_database':
    unless  => "/usr/bin/test $( mysql -N -B -e \"show tables from test like 'test' ;\"  )",
    command => "/usr/bin/mysql < /usr/local/lib/demo/data.sql",
    require => [Package['mariadb'], Service['mariadb']]
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    backup => true,
    source => 'puppet:///modules/demo_app/nginx.conf'
  }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => [Package['nginx'],File['/etc/nginx/conf.d/default.conf']]
  }

  file { '/var/run/demo':
    ensure => directory;
  }
}
