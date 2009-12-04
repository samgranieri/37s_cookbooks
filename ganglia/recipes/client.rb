
package "ganglia-monitor"

service "ganglia-monitor" do
  enabled true
  running true
  pattern "gmond"
end

template "/etc/ganglia/gmond.conf" do
  source "gmond.conf.erb"
  owner "ganglia"
  group "ganglia"
  mode 0644
  notifies :restart, resources(:service => "ganglia-monitor")
end
