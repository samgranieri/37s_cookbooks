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
