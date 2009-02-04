#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

package "postfix" do
  action :upgrade
end

service "postfix" do
  action [:enable, :start]
end
