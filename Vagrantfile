# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = "dev-moodle"
  config.vm.box = "trusty64"
  config.vm.box_url = "http://files.vagrantup.com/trusty64.box"
  config.vm.network :private_network, ip: "192.168.50.50"
  config.vm.network :forwarded_port, guest: 80, host: 4321

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  # Allow vagrant to use host machine's ssh agent
  config.ssh.forward_agent = true
  # Allow x11 passthrough for running GUI stuff
  config.ssh.forward_x11 = true

  config.vm.provision :shell, :path => "./shell/puppet_modules.sh"

  config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "site.pp"
      puppet.manifests_path = "./puppet/manifests"
      puppet.module_path = "./puppet/modules"
      puppet.options = "--environment development"
  end
end
