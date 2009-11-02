chef Mash.new unless attribute?("chef")
chef[:server_version] = "0.7.10"
chef[:server_path] = "#{languages[:ruby][:gems_dir]}/gems/chef-server-#{chef[:server_version]}"
chef[:server_slice_path] = "#{languages[:ruby][:gems_dir]}/gems/chef-server-slice-#{chef[:server_version]}"
