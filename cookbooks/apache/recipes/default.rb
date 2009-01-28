#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "apache" do
  package_name 'apache2'
  action :install
end
