#
# Cookbook Name:: nagios
# Recipe:: server
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apache2"

file "/etc/nagios3/htpasswd.users" do
  owner "nagios"
  group "www-data"
  mode 0750
  action :create
end

# using the node object inside this block fails, so we assign for now
userlist = node[:nagios][:users]

add_htpasswd_users "/etc/nagios3/htpasswd.users" do
  users userlist
end

package "nagios" do
  package_name 'nagios3'
  action :install
end

hosts = []
search(:node, "*") {|n| hosts << n }

service "nagios3" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable ]
end

nagios_conf "nagios" do
  config_subdir false
end

nagios_conf "commands"
nagios_conf "contacts"
nagios_conf "notification_commands"
nagios_conf "hosts" do
  variables ({:hosts => hosts})
end

service "nagios3" do
  action :start
end