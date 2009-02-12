chef Mash.new unless attribute?("chef")
chef[:client_interval] = "60"
chef[:client_splay] = "10"