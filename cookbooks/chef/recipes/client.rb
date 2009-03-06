require_recipe "runit"
include_recipe "logrotate"

template "/etc/chef/client.rb" do
  mode 0644
  source "client.rb.erb"
  action :create
end

directory "/var/log/chef"

execute "Initialize node in chef server" do
  command "#{node[:chef][:client_path]} -t #{`cat /etc/chef/validation_token`}"
end

runit_service "chef-client"

logrotate "chef-client" do
  rotate_count 5
  files "/var/log/chef/*.log"
end