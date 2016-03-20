class demo_app::healthcheck {
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
    subscribe => File[
        '/usr/lib/systemd/system/healthcheck.service',
        '/usr/local/lib/demo/healthcheck.sh' 
    ]
  }
}
