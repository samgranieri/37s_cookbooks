rubygems Mash.new unless attribute?("rubygems")
rubygems[:sources] = ['gems'] unless rubygems.has_key?(:sources)
