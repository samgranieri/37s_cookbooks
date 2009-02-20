include_recipe "build-essential"
require_recipe "postfix"
require_recipe "ssh::server"

node[:groups].each do |u, config|
  group u do
    gid config[:gid]
  end
end

node[:users].each do |u, config|
  user u do
    comment config[:comment]
    uid config[:uid]
    gid config[:group].to_s
    home "/home/#{u}"
    shell "/bin/bash"
    password config[:password]
    supports :manage_home => true
  end
  
  directory "/home/#{u}/.ssh" do
    action :create
    owner u
    group config[:group].to_s
    mode 0700
  end
end


directory "/u" do
  action :create
  owner "root"
  group "admin"
  mode 0775
end

directory "/u/sites" do
  action :create
  owner "site"
  group "site"
  mode 0775
end

require_recipe "ssh_keys"
require_recipe "sudo"
