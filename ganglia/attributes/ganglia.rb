set_unless[:ganglia][:grid_name] = 'Ganglia'
set_unless[:ganglia][:server_fqdn] = 'ganglia'
set_unless[:ganglia][:cluster_name] = 'Default'
set_unless[:ganglia][:servers] = [ '1.2.3.4:3737', '5.6.7.8:3737' ]
set_unless[:ganglia][:clusters] = [ { :name => 'Default', :port => 1234, :interval => 15 } ]
set_unless[:ganglia][:disks] = []
