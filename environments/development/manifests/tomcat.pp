class tomcat {
    package { 'tomcat':
      ensure   => installed,
    }
    ->
    service { 'tomcat':
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
      provider   => 'systemd'
    }
}
