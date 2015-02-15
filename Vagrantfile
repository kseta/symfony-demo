# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  {
    "symfony-demo-ci"         => {"ip" => "192.168.50.100", "role" => "ci"},
    "symfony-demo-develop"    => {"ip" => "192.168.50.101", "role" => "app"},
    "symfony-demo-staging"    => {"ip" => "192.168.50.102", "role" => "app"},
    "symfony-demo-production" => {"ip" => "192.168.50.103", "role" => "app"}
  }.each{|name, parameters|
    config.vm.define name do |box|
      box.vm.network :private_network, ip: parameters["ip"]
      box.vm.provision :shell, :path => "vagrant.#{parameters['role']}.sh"
    end
  }
  config.vm.box = "CentOS-6.3-x86_64-minimal"
  config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.3-x86_64-v20130101.box"
  config.ssh.forward_agent = true
end
