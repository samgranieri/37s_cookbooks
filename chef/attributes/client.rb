chef Mash.new unless attribute?("chef")
chef[:client_version] = "0.7.14"
chef[:client_path] = `which chef-client`.chomp
chef[:client_interval] = "300"
chef[:client_splay] = "20"
chef[:log_path] = "/var/log/chef/client.log"
chef[:client_enable] = false unless chef.has_key?(:client_enable)