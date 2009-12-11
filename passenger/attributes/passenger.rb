default.passenger[:version]          = '2.2.7'
default.passenger[:root_path]        = "#{languages[:ruby][:gems_dir]}/gems/passenger-#{passenger[:version]}"
default.passenger[:module_path]      = "#{passenger[:root_path]}/ext/apache2/mod_passenger.so"
default.passenger[:apache_load_path] = '/etc/apache2/mods-available/passenger.load'
default.passenger[:apache_conf_path] = '/etc/apache2/mods-available/passenger.conf'

default.passenger[:soft_memory_limit] = 230 unless passenger.has_key?(:soft_memory_limit)
default.passenger[:hard_memory_limit] = 500 unless passenger.has_key?(:hard_memory_limit)
