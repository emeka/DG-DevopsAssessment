class demo_app {

  package { 'java':
    ensure => present
  }

  package { 'mariadb':
    ensure => present
  }

  package { 'mariadb-server':
    ensure => present
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

}
