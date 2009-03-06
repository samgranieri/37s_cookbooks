require_recipe "runit"

template "/etc/chef/client.rb" do
  owner "chef"
  group "chef"
  mode 0644
  source "client.rb.erb"
  action :create
end

execute "Initialize node in chef server" do
  command "#{node[:chef][:client_path]} -t `cat /etc/chef/validation_token`"
end

runit_service "chef-client"