passenger Mash.new unless attribute?("passenger")
passenger[:version]          = '2.2.5'
passenger[:root_path]        = "#{gems_path}/gems/passenger-#{passenger[:version]}"
passenger[:module_path]      = "#{passenger[:root_path]}/ext/apache2/mod_passenger.so"
passenger[:apache_load_path] = '/etc/apache2/mods-available/passenger.load'
passenger[:apache_conf_path] = '/etc/apache2/mods-available/passenger.conf'

passenger[:soft_memory_limit] = 230 unless passenger.has_key?(:soft_memory_limit)
passenger[:hard_memory_limit] = 500 unless passenger.has_key?(:hard_memory_limit)