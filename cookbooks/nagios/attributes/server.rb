nagios Mash.new unless attribute?("nagios")

nagios[:root] = "/etc/nagios3"
nagios[:config_subdir] = "conf.d"
nagios[:users] = Mash.new
nagios[:users]["nagiosadmin"] = "casp3end6e"
nagios[:notifications_enabled] = true

# This setting is effectively sets the minimum interval (in seconds) nagios can handle.
# Other interval settings provided in seconds will calculate their actual from this value, since nagios works in 'time units' rather than allowing definitions everywhere in seconds

nagios[:interval_length] = 15

