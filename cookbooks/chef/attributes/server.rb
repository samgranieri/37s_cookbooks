gems_path `gem env gemdir`.chomp!
chef Mash.new unless attribute?("chef")
chef[:server_version] = "0.5.6"
chef[:server_path] = "#{gems_path}/gems/chef-server-#{chef[:server_version]}"