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

template "/etc/nagios3/nagios.cfg" do
  owner "nagios"
  group "nagios"
  source "nagios.cfg.erb"
  mode 0440
end

template "/etc/nagios3/commands.cfg" do
  owner "nagios"
  group "nagios"
  source "commands.cfg.erb"
  mode 0440
end

@hosts = []
@hosts = search(:node, "*") {|node| (@hosts << node }

template "/etc/nagios3/conf.d/hosts.cfg" do
  owner "nagios"
  group "nagios"
  source "hosts.cfg.erb"
  variables({:hosts => @hosts})
  mode 0440
end
