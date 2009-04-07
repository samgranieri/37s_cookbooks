include_recipe "runit"
include_recipe "apache2"
include_recipe "passenger"

gem_package "chef-server-slice" do
  version node[:chef][:server_version]
end

gem_package "chef-server" do
  version node[:chef][:server_version]
end

group "admin" do
  gid 8000
end

user "chef" do
  comment "Chef user"
  gid "admin"
  uid 8000
  home "/var/chef"
  shell "/bin/bash"
end

directory "/etc/chef" do
  owner "chef"
  mode 0775
end

directory "/var/log/chef" do
  owner "chef"
  group "admin"
  mode 0775
end

directory "/var/chef/openid" do
  owner "chef"
  group "admin"
  mode 0775
end

directory "/var/chef/cache" do
  owner "chef"
  group "admin"
  mode 0775
end

directory "/var/chef/search_index" do
  owner "chef"
  group "admin"
  mode 0775
end

directory "/var/chef/openid/cstore" do
  owner "chef"
  group "admin"
  mode 0775
end

template "/etc/chef/server.rb" do
  owner "chef"
  group "admin"
  mode 0664
  source "server.rb.erb"
  action :create
end

template "/etc/chef/client.rb" do
  owner "chef"
  group "admin"
  mode 0664
  source "client.rb.erb"
  action :create
end

gem_package "stompserver" do
  action :install
end

runit_service "stompserver"

directory "/var/chef/couchdb"

link "/var/lib/couchdb" do
  to "/var/chef/couchdb"
end

package "couchdb"

directory "/var/chef/couchdb" do
  owner "couchdb"
  group "couchdb"
  recursive true
end

service "couchdb" do
  supports :restart => true, :status => true
  action [ :enable, :start ]
end

runit_service "chef-indexer"

template "/etc/chef/server-vhost.conf" do
  source 'chef-server-vhost.conf.erb'
  action :create
  owner "root"
  group "www-data"
  0664
  notifies :restart, resources(:service => "apache2")
end

template "#{node[:chef][:server_path]}/config.ru" do
  source 'config.ru.erb'
  action :create
  owner "root"
  group "admin"
  mode 0664
  notifies :restart, resources(:service => "apache2")
end

template "#{node[:chef][:server_path]}/config/environments/production.rb" do
  source 'merb-production.rb.erb'
  action :create
  owner "root"
  group "admin"
  mode 0664
  notifies :restart, resources(:service => "apache2")
end

template "#{node[:chef][:server_path]}/config/init.rb" do
  source 'chef-server.init.rb.erb'
  action :create
  owner "root"
  group "admin"
  mode 0664
  notifies :restart, resources(:service => "apache2")
end

link "/var/chef/public" do
  to "#{node[:chef][:server_path]}/public"
end

apache_site "chef-server" do
  config_path "/etc/chef/server-vhost.conf"
end

cron "compact chef couchDB" do
  command "curl -X POST http://localhost:5984/chef/_compact >> /var/log/cron.log 2>&1"
  hour "5"
  minute "0"
end