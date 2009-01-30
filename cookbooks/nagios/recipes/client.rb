#
# Cookbook Name:: nagios
# Recipe:: client
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#


directory '/var/nagios' do
  owner "nagios"
  group "nagios"
  mode "0755"  
end

remote_directory "/var/nagios/custom-plugins" do
  source "plugins"
  files_backup 5
  files_owner "nagios"
  files_group "nagios"
  files_mode 0644
  owner "nagios"
  group "nagios"
  mode "0755"
end