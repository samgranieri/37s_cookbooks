
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

remote_file "/usr/local/bin/ganglia_disk_stats.pl" do
  source "ganglia_disk_stats.pl"
  owner "root"
  group "root"
  mode "0755"
end

node[:filesystem].each do |device,options|
  next unless options[:mount] == "/"
  disk = device.gsub(/\/dev\//, '').gsub(/[0-9]+$/, '')
  cron "gather ganglia I/O statistics for #{disk}" do
    command "/usr/local/bin/ganglia_disk_stats.pl #{disk}"
    minute "*"
  end
end

node[:ganglia][:disks].each do |disk|
  cron "gather ganglia I/O statistics for #{disk}" do
    command "/usr/local/bin/ganglia_disk_stats.pl #{disk}"
    minute "*"
  end
end
  
