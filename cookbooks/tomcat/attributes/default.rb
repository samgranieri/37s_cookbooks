tomcat Mash.new unless attribute?(:tomcat)
tomcat[:user] = "tomcat6" unless tomcat.has_key?(:user)
tomcat[:heap_size] = "128M" unless tomcat.has_key?(:heap_size)
tomcat[:stack_size] = "16M" unless tomcat.has_key?(:stack_size)
