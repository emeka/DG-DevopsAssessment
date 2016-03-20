class demo_app::app {

  package { 'java':
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

  file { '/var/run/demo':
    ensure => directory;
  }
}
