class firewall {
  file { '/usr/local/lib/demo/firewall.sh':
    ensure => file,
    source => 'puppet:///modules/firewall/firewall.sh',
    mode => '0755',
    owner => 'root',
    group => 'root'
  }

  exec { 'firewall':
    command => '/usr/local/lib/demo/firewall.sh',
    require => File['/usr/local/lib/demo/firewall.sh']
  }
}
