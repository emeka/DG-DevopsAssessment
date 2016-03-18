Vagrant.configure('2') do |config|

  config.vm.hostname = 'devops-challenge'
  config.vm.box = 'puppetlabs/centos-7.0-64-puppet'

  forwarded_ports = {'80' => '18080', '8000' => '8000', '1234' => '1234' }

  forwarded_ports.each do |k,v|
    config.vm.network :forwarded_port, guest: "#{k}",  host: "#{v}", auto_correct: true
  end

  config.vm.provider :virtualbox do |virtualbox, override|
    virtualbox.customize ['modifyvm', :id, '--memory', '1024']
  end

  config.ssh.forward_agent = true

  config.vm.provision :puppet do |puppet|
    puppet.environment          = 'development'
    puppet.environment_path     = 'environments'
    puppet.hiera_config_path    = 'hiera.yaml'
    puppet.options              = '--verbose'
    puppet.facter = {
      "role" => "challenge"
    }
  end
end
