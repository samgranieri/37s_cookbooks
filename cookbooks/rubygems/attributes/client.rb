rubygems Mash.new unless attribute?("rubygems")
rubygems[:sources] = ['gems', 'localgems'] unless rubygems.has_key?(:sources)
