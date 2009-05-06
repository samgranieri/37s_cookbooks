require_recipe "runit"
include_recipe "logrotate"

gem_package "ohai" do
  action :remove
  version "0.2.1"
end

gem_package "ohai" do
  action :install
  version "0.2.0"
  source "http://gems.opscode.com"
end

gem_package "chef" do
  action :upgrade
  version node[:chef][:client_version]
  source "http://gems.opscode.com"
end

template "/etc/chef/client.rb" do
  mode 0644
  source "client.rb.erb"
  action :create
end

directory "/var/log/chef"

logrotate "chef-client" do
  rotate_count 5
  files "/var/log/chef/*.log"
end

execute "Register client node with chef server" do
  command "#{node[:chef][:client_path]} -t \`cat /etc/chef/validation_token\`"
  
  only_if { File.exists?("/etc/chef/validation_token") }
  not_if  { File.exists?("/var/chef/cache/registration") }
end

execute "Remove the validation token" do
  command "rm /etc/chef/validation_token"
  only_if { File.exists? "/etc/chef/validation_token" }
end

runit_service "chef-client"

service "chef-client" do
  action :enable
end