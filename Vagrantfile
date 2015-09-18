Vagrant.configure('2') do |config|

  config.vm.box = 'puppetlabs/centos-7.0-64-nocm'

  config.vm.graceful_halt_timeout = 300
  config.vm.base_mac = '0800277C11F2'
  config.vm.host_name = 'vagrant.aem'

  config.vm.provider 'virtualbox' do |v|
    v.name = 'test-aem'
    v.cpus = 2
    v.memory = 8192
  end

  config.vm.provision 'shell', path: 'setup/update-vm.sh'

  config.vm.network :forwarded_port, guest:80, host:9080
  config.vm.network :forwarded_port, guest:8080, host:9880
  config.vm.network :forwarded_port, guest:8009, host:9809
  config.vm.network :forwarded_port, guest:4502, host:4502
  config.vm.network :forwarded_port, guest:4503, host:4503
  config.vm.network :forwarded_port, guest:30300, host:30300
  config.vm.network :forwarded_port, guest:30303, host:30303
  config.vm.network :forwarded_port, guest:30304, host:30304

end