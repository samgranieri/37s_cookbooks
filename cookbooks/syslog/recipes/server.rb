require_recipe "syslog"

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng-server.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "syslog-ng")
end

remote_file "/usr/local/bin/logsort" do
  source "logsort"
  mode 0755
end

if node[:syslog_ng][:apps]
  node[:syslog_ng][:apps].each do |app, config|
    directory root+"/#{app}" do
      owner "app"
      group "app"
      mode 0750
    end
  end
end