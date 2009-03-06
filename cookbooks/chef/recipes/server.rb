include_recipe "runit"
include_recipe "apache2"
include_recipe "passenger"
require_recipe "apache2::mod_authn_yubikey"

group "chef" do
  gid 8000
end

gem_package "chef-server"

user "chef" do
  comment "Chef user"
  gid "chef"
  uid 8000
  home "/var/chef"
  shell "/bin/bash"
end

directory "/etc/chef" do
  owner "chef"
  mode 0755
end

directory "/var/log/chef" do
  owner "chef"
  group "chef"
  mode 0755
end

directory "/var/chef/openid" do
  owner "chef"
  group "chef"
  mode 0755
end

directory "/var/chef/cache" do
  owner "chef"
  group "chef"
  mode 0755
end

directory "/var/chef/search_index" do
  owner "chef"
  group "chef"
  mode 0755
end

directory "/var/chef/openid/cstore" do
  owner "chef"
  group "chef"
  mode 0755
end

template "/etc/chef/server.rb" do
  owner "chef"
  group "chef"
  mode 0644
  source "server.rb.erb"
  action :create
end

template "/etc/chef/client.rb" do
  owner "chef"
  group "chef"
  mode 0644
  source "client.rb.erb"
  action :create
end

gem_package "stompserver" do
  action :install
end
runit_service "stompserver"

package "couchdb"

directory "/var/lib/couchdb" do
  owner "couchdb"
  group "couchdb"
  recursive true
end

service "couchdb" do
  supports :restart => true, :status => true
  action [ :enable, :start ]
end

runit_service "chef-indexer"

template "/etc/apache2/sites-available/chef-server" do
  source 'chef-server-vhost.conf.erb'
  action :create
  owner "root"
  group "www-data"
  mode 0640
end

template "#{node[:chef][:server_path]}/lib/config.ru" do
  source 'config.ru.erb'
  action :create
  owner "root"
  group "chef"
  mode 0644
end

link "/var/chef/public" do
  to "#{node[:chef][:server_path]}/lib/public"
end

apache_site "chef-server"