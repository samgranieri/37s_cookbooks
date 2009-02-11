chef Mash.new unless attribute?("chef")
chef[:client_interval] = "10"
chef[:client_splay] = "2"