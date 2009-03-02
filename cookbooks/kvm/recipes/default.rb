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


