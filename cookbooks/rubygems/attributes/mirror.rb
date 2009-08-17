rubygems Mash.new unless attribute?("rubygems")
rubygems[:mirror] = Mash.new unless rubygems.has_key?(:mirror)
rubygems[:mirror][:base_path] = "/u/mirrors/gems"
rubygems[:mirror][:aliases] = ['gems','gems.37signals.com']
