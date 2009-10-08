#
# Cookbook Name:: gateway
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

directory "/home/git/.ssh" do
  owner "git"
  group "git"
  mode 0700
end

remote_file "/home/git/.ssh/authorized_keys" do
  source "authorized_keys"
  owner "git"
  group "git"
  mode 0600
end

remote_file "/home/git/git-proxy" do
  source "git-proxy"
  owner "root"
  group "root"
  mode 0755
end
