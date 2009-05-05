include_recipe "runit"
include_recipe "apache2"
include_recipe "passenger"
include_recipe "openssl"
require_recipe "couchdb"

gem_package "chef-server-slice" do
  version node[:chef][:server_version]
end

gem_package "chef-server" do
  version node[:chef][:server_version]
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

remote_file "/usr/local/bin/chef-api" do
  source "chef-api"
  mode 0755
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

link "/var/lib/couchdb" do
  to "/var/chef/couchdb"
end

directory "/var/chef/couchdb/#{node[:couchdb][:version]}" do
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

link "/var/chef/public" do
  to "#{node[:chef][:server_path]}/public"
end

directory "#{node[:chef][:server_path]}/public/slices" do
  owner "root"
  group "admin"
  mode "0755"
end

link "#{node[:chef][:server_path]}/public/slices/chef-server-slice" do
  to "#{node[:chef][:server_slice_path]}/public"
end

ssl_cert "/var/chef/certificates" do
  fqdn "chef.#{node[:domain]}"
end

apache_site "chef-server" do
  config_path "/etc/chef/server-vhost.conf"
end

cron "compact chef couchDB" do
  command "curl -X POST http://localhost:5984/chef/_compact >> /var/log/cron.log 2>&1"
  hour "5"
  minute "0"
end