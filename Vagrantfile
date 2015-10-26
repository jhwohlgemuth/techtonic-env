# -*- mode: ruby -*-
# vi: set ft=ruby :

$org_name = "techtonic"

Vagrant.configure(2) do |config|
    config.vm.define "techtonic" do |env|
        env.vm.box = "techtonic/env"
        env.vm.hostname = "home"
        env.vm.post_up_message = "All Done!"
    end
    config.vm.synced_folder "share", "/home/vagrant/share", create: true
    config.vm.synced_folder "vault", "/home/vagrant/Documents/vault", create: true
    config.vm.network "forwarded_port", guest: 1337, host: 1337, auto_correct: true #custom
    config.vm.network "forwarded_port", guest: 4669, host: 4669, auto_correct: true #custom
    config.vm.network "forwarded_port", guest: 4873, host: 4873, auto_correct: true #sinopia
    config.vm.network "forwarded_port", guest: 8000, host: 8000, auto_correct: true
    config.vm.network "forwarded_port", guest: 8080, host: 8080, auto_correct: true #jenkins
    config.vm.network "forwarded_port", guest: 8111, host: 8111   #teamcity
    config.vm.network "forwarded_port", guest: 5984, host: 5984   #couch
    config.vm.network "forwarded_port", guest: 6379, host: 6379   #redis
    config.vm.network "forwarded_port", guest: 7001, host: 7001   #weblogic
    config.vm.network "forwarded_port", guest: 27017, host: 27017 #mongodb
    config.vm.network "forwarded_port", guest: 46692, host: 46692, auto_correct: true #custom
    config.vm.provider "virtualbox" do |vb|
        vb.name = $org_name + "-env-" + Time.now.to_i.to_s
        vb.gui = true
        vb.cpus = 4
        vb.memory = 8192
        vb.customize ["modifyvm", :id, "--monitorcount", "1"]
        vb.customize ["setextradata", "global", "GUI/Customizations", "noMenuBar"]
    end
end