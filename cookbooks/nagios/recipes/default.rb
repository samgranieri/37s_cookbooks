#
# Cookbook Name:: nagios
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "nagios" do
  package_name 'nagios3'
  action :install
end