chef Mash.new unless attribute?("chef")
chef[:client_path] = `which chef-client`.chomp
chef[:client_interval] = "300"
chef[:client_splay] = "20"
chef[:log_path] = "/var/log/chef/client.log"