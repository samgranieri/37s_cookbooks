postfix Mash.new unless attribute?("postfix")
default[:postfix][:myorigin] = fqdn
default[:postfix][:mynetworks] = []
