#
# Cookbook Name:: sphinx
# Recipe:: default
#
# Copyright 2010, 37signals
#
# All rights reserved - Do Not Redistribute
#

script "install sphinx" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  
  code <<-EOH
wget http://dist/packages/sphinx-#{node[:sphinx][:version]}.tar.gz && \
tar xfz sphinx-#{node[:sphinx][:version]}.tar.gz && \
cd sphinx-#{node[:sphinx][:version]} && \
./configure --prefix=/usr/local && \
make install
rm -rf /tmp/sphinx-#{node[:sphinx][:version]}.tar.gz /tmp/sphinx-#{node[:sphinx][:version]}
EOH
  not_if { File.exist?("/usr/local/bin/search") && `/usr/local/bin/search`.match(/Sphinx #{node[:sphinx][:version]}/) }
end

node[:applications].each do |name, config|
  next unless config[:sphinx] == true

  directory "/u/apps/#{name}/shared/sphinx" do
    action :create
    recursive true
    owner "app"
    group "app"
    mode "0755"
  end
  
  bluepill_monitor "sphinx_#{name}" do
    source "bluepill_sphinx.conf.erb"
    rails_root "/u/apps/#{name}/current"
    config_file node[:staging] == true ? 'staging.conf' : 'production.conf'
    user "app"
    group "app"
  end  

  logrotate "sphinx_#{name}" do
    restart_command "kill -USR1 `cat /u/apps/#{name}/shared/pids/searchd.pid`"
    files "/u/apps/#{name}/shared/log/*.log"
    frequency "daily"
  end
end

