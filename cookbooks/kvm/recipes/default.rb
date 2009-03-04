#
# Cookbook Name:: kvm
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "kvm"

remote_directory "/usr/local/share/kvm/templates" do
  source "templates"
  files_backup 2
  files_owner "root"
  files_group "admin"
  files_mode 0640
  owner "root"
  group "admin"
  mode 0750
end

remote_directory "/lib/modules/#{@node[:kernel][:release]}/extra" do
  source "modules/#{@node[:kernel][:release]}"
  files_backup 0
  files_owner "root"
  files_group "root"
  files_mode 0644
  owner "root"
  group "root"
  mode 0755
end
