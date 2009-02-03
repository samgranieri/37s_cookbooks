#
# Cookbook Name:: nagios
# Recipe:: server
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "nagios" do
  package_name 'nagios3'
  action :install
end

file @node[:nagios][:root]+"/conf.d/contacts_nagios2.cfg" do
  action :delete
end

hosts = []
search(:node, "*") {|node| hosts << node }

service "nagios3" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

nagios_conf "nagios"
nagios_conf "commands"
nagios_conf "notification_commands"
nagios_conf "hosts" do
  variables ({:hosts => hosts})
end