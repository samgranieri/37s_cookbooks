nagios Mash.new unless attribute?("nagios")

nagios[:root] = "/etc/nagios3"
nagios[:config_subdir] = "conf.d"
nagios[:users] = Mash.new
nagios[:users]["nagiosadmin"] = "casp3end6e"
nagios[:notifications_enabled] = true
nagios[:check_external_commands] = true

# This setting is effectively sets the minimum interval (in seconds) nagios can handle.
# Other interval settings provided in seconds will calculate their actual from this value, since nagios works in 'time units' rather than allowing definitions everywhere in seconds

nagios[:interval_length] = 1

# Provide all interval values in seconds
%w(default_host default_service hosts services service_templates).each do |var|
nagios[var.to_sym] = Mash.new
end

nagios[:default_host][:check_interval] = 15
nagios[:default_host][:retry_interval] = 15
nagios[:default_host][:notification_interval] = 300
nagios[:default_host][:max_check_attempts] = 1

nagios[:default_host][:check_interval] = 60
nagios[:default_host][:retry_interval] = 15
nagios[:default_host][:notification_interval] = 1200
nagios[:default_host][:max_check_attempts] = 3

