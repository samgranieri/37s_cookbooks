require_recipe "postfix"

node[:groups].each do |u, config|
  group u do
    gid config[:gid]
  end
end

node[:users].each do |u, config|
  user u do
    comment config[:comment]
    uid config[:uid]
    gid node[:groups][config[:group]][:gid]
    home "/home/#{u}"
    shell "/bin/bash"
    password config[:password]
    supports :manage_home => true
  end
  directory "/home/#{u}/.ssh" do
    action :create
    owner u
    group config[:group]
    mode 0700
  end
end


directory "/u" do
  action :create
  owner "root"
  group "admin"
  mode 0775
end

directory "/u/apps" do
  action :create
  owner "app"
  group "app"
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
