# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "vault", primary: true do |server|
    server.vm.network "private_network", ip: "192.168.33.10"
    server.vm.box = "ubuntu/xenial64"
    server.vm.network "forwarded_port", guest: 8200, host: 8200
  end

  config.vm.define "serverHttp" do |serverHttp|
      serverHttp.vm.network "private_network", ip: "192.168.33.11"
      serverHttp.vm.network "forwarded_port", guest: 80, host: 5000
      serverHttp.vm.box = "ubuntu/xenial64"
  end

  config.vm.define "usuario" do |usuario|
        usuario.vm.network "private_network", ip: "192.168.33.12"
        usuario.vm.box = "ubuntu/xenial64"
  end
end
