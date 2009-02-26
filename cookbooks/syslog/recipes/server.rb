require_recipe "syslog"

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng-server.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "syslog-ng")
  variables(:applications => node[:applications])
end

remote_file "/usr/local/bin/logsort" do
  source "logsort"
  mode 0755
end

if node[:applications]
  node[:applications].each do |app, config|
    directory root+"/#{app}" do
      owner "app"
      group "app"
      mode 0750
    end
  end
end

logrotate "applications" do
  restart_command "/etc/rc.d/init.d/syslog-ng reload 2>&1 || true"
  files node[:applications].keys.collect{|name| root+"/#{name}/*.log" }
  frequency "daily"
end