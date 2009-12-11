default.chef[:server_version] = "0.7.14"
default.chef[:server_path] = "#{languages[:ruby][:gems_dir]}/gems/chef-server-#{chef[:server_version]}"
default.chef[:server_slice_path] = "#{languages[:ruby][:gems_dir]}/gems/chef-server-slice-#{chef[:server_version]}"
