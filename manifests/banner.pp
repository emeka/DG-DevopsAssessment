# Displays information banner
class banner {
  $label_env = sprintf('%-70s',"Environment: ${environment}")
  $label_fqdn = sprintf('%-70s',"FQDN: ${fqdn}")
  $label_role = sprintf('%-70s',"Role: ${role}")

  $banner = "
######################## Solera DevOps Challenge #########################
#                                                                        #
# ${label_env} #
#                                                                        #
# ${label_fqdn} #
#                                                                        #
# ${label_role} #
#                                                                        #
##########################################################################
"

  file { '/etc/motd':
    ensure  => file,
    content => $banner,
    mode    => '0644',
    owner   => 'root',
    group   => 'root'
  }
}
