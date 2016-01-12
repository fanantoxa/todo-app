# encoding: utf-8
# This file originally created at http://rove.io/f617cd8dbf3a2322d6f9376297c6575e

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "opscode-ubuntu-12.04_chef-11.4.0"
  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.4.0.box"
  config.ssh.forward_agent = true

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.add_recipe :apt
    chef.add_recipe 'rvm::vagrant'
    chef.add_recipe 'rvm::system'
    chef.add_recipe 'git'
    chef.add_recipe 'postgresql::server'
    chef.json = {
      :git        => {
        :prefix => "/usr/local"
      },
      :rvm        => {
        'user'          => 'vagrant',
        'default_ruby'  => 'rbx',
        'rubies'        => ['2.2.1']
      },
      :postgresql => {
        :config   => {
          :listen_addresses => "*",
          :port             => "5432"
        },
        :pg_hba   => [
          {
            :type   => "local",
            :user   => "todo_user",
            :password => 'testing'
          },
          {
            :type   => "host",
            :db     => "all",
            :user   => "all",
            :addr   => "0.0.0.0/0",
            :method => "md5"
          },
          {
            :type   => "host",
            :db     => "all",
            :user   => "all",
            :addr   => "::1/0",
            :method => "md5"
          }
        ],
        :password => {
          :postgres => "password"
        }
      },
      :rake       => [
        {
          working_directory: "/vagrant",
          arguments: "db:create:all --trace",
          action: :run        
        },
        {
          working_directory: "/vagrant",
          arguments: "db:migrate --trace",
          action: :run        
        },
        {
          working_directory: "/vagrant",
          arguments: "db:migrate --trace RAILS_ENV=test",
          action: :run        
        }
      ]
    }
  end
end
