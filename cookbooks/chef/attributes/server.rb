gems_path `gem env gemdir`.chomp!
chef Mash.new unless attribute?("chef")
chef[:server_version] = "0.6.2"
chef[:server_path] = "#{gems_path}/gems/chef-server-#{chef[:server_version]}"
chef[:server_slice_path] = "#{gems_path}/gems/chef-server-slice-#{chef[:server_version]}"
