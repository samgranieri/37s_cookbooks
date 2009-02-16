apt = Mash.new unless attribute?("apt")
apt[:mirror] = Mash.new
apt[:mirror][:base_path] = "/u/mirrors/apt"
