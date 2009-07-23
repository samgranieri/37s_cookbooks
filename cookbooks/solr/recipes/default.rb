#
# Cookbook Name:: solr
# Recipe:: default
#
# Copyright 2009, 37signals
#
# All rights reserved - Do Not Redistribute
#

require_recipe "tomcat"

node[:active_applications].each do |app|
  template "/etc/tomcat6/Catalina/localhost/#{app}.xml" do
    source "solr.xml.erb"
    variables(:app => app)
    owner node[:tomcat][:user]
    mode "0644"
  end

  directory "#{node[:solr][:root]}/#{app}" do
    owner "app"
    group "app"
    mode 0755
  end

  directory "#{node[:solr][:root]}/#{app}/data" do
    owner "app"
    group "app"
    mode 0755
  end

  if node[:solr][:data_device]
    mount "#{node[:solr][:root]}/#{app}/data" do
      device node[:solr][:data_device]
      fstype "ext3"
    end
  end

  remote_file "#{node[:solr][:root]}/#{app}/#{node[:solr][:war][:file]}" do
    source "#{node[:solr][:war][:url]}/#{node[:solr][:war][:file]}"
    owner "app"
    group "app"
    mode 0644
  end
end
