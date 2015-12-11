# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "rvanider/oel67min"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |v|
    v.name = "keycloak"
    v.cpus = 2
  end

  config.vm.provider "parallels" do |prl|
    prl.name = "keycloak"
    prl.cpus = 2
  end

  config.vm.hostname = "keycloak"
  config.vm.network "forwarded_port", guest: 8080, host: 8081

  config.vm.provision :shell, path: "bootstrap.sh"
end
