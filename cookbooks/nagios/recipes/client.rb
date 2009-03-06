package "nagios-nrpe-server"

service "nagios-nrpe-server" do
  action :enable
  supports :restart => true, :reload => true
end

directory "/u/nagios" do
  owner "nagios"
  group "nagios"
end

remote_directory "/u/nagios/plugins" do
  source "plugins"
  files_backup 5
  files_owner "nagios"
  files_group "nagios"
  files_mode 0755
  owner "nagios"
  group "nagios"
  mode 0755
end

template "/etc/nagios/nrpe.cfg" do
  source "nrpe.cfg.erb"
  notifies :reload, resources(:service => "nagios-nrpe-server")
end
