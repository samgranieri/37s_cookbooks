recipes << "base"
chef Mash.new unless attribute?("chef")
chef[:server_version] = "0.5.3"
chef[:server_path] = "#{node[:base][:gems_path]}/chef-server-#{chef[:server_version]}"