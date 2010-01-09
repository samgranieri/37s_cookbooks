
package "ganglia-monitor"

service "ganglia-monitor" do
  enabled true
  running true
  pattern "gmond"
end

template "/etc/ganglia/gmond.conf" do
  source "gmond.conf.erb"
  backup false
  owner "ganglia"
  group "ganglia"
  mode 0644
  variables(:server => false,
            :cluster => {
              :name => @node[:ganglia][:cluster_name],
              :port => @node[:ganglia][:clusters].find { |c| c[:name] == @node[:ganglia][:cluster_name] }[:port]
            })
  notifies :restart, resources(:service => "ganglia-monitor")
end
