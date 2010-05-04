default.chef[:server_version] = "0.8.11"
default.chef[:server_path] = "#{node[:languages][:ruby][:gems_dir]}/gems/chef-server-#{chef[:server_version]}"
default.chef[:server_api_path] = "#{node[:languages][:ruby][:gems_dir]}/gems/chef-server-api-#{chef[:server_version]}"
default.chef[:server_webui_path] = "#{node[:languages][:ruby][:gems_dir]}/gems/chef-server-webui-#{chef[:server_version]}"
default.chef[:webui_default_password] = '7bc318032e'
