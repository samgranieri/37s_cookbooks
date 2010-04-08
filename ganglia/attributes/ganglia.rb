default.ganglia[:grid_name] = 'Ganglia'
default.ganglia[:server_fqdn] = 'ganglia'
default.ganglia[:cluster_name] = 'Default'
default.ganglia[:servers] = [ '1.2.3.4:3737', '5.6.7.8:3737' ]
default.ganglia[:clusters] = [ { :name => 'Default', :port => 1234, :interval => 15 } ]
default.ganglia[:disks] = []
