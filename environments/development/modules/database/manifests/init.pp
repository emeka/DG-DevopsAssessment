class database {
  package { 'mariadb':
    ensure => present
  }

  package { 'mariadb-server':
    ensure => present
  }

  file { '/usr/local/lib/demo/data.sql':
    ensure  => file,
    source  => 'puppet:///modules/database/data.sql',
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }

  service { 'mariadb':
    ensure => running,
    enable => true,
    require => Package['mariadb-server']
  }

  exec { 'init_database':
    unless  => "/usr/bin/test $( mysql -N -B -e \"show tables from test like 'test' ;\"  )",
    command => "/usr/bin/mysql < /usr/local/lib/demo/data.sql",
    require => [Package['mariadb'], Service['mariadb'], File['/usr/local/lib/demo/data.sql']]
  }
}
