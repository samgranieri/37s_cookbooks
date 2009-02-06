package "syslog-ng" do
  action :install
end

service "apache2" do
  supports :restart => true, :reload => true
  action :enable
end

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng.conf.erb"
  owner "root"
  group "root"
  mode 0644
end