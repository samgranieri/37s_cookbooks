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
    directory node[:syslog_ng][:root] + "/#{app}" do
      owner "app"
      group "app"
      mode 0750
    end
  end
  logrotate "applications" do
    restart_command "/etc/init.d/syslog-ng reload 2>&1 || true"
    files node[:applications].keys.collect{|name| root+"/#{name}/*.log" }
    frequency "daily"
  end
end

directory node[:syslog_ng][:root] + "/syslog" do
  owner "root"
  group "app"
  mode 0750
end

logrotate "syslog-remote" do
  restart_command "/etc/init.d/syslog-ng reload 2>&1 || true"
  files ['/u/logs/syslog/messages', "/u/logs/syslog/secure", "/u/logs/syslog/maillog", "/u/logs/syslog/cron", "/u/logs/syslog/bluepill"]
end

node[:applications].each do |app, config|
  next unless !config[:syslog_files].nil? && config[:syslog_files][:logsort]
  
  cron "logsort log rotation: #{app}" do
    command "find /u/logs/#{app} -maxdepth 1 -type d -mtime +7 -exec rm -rf {} \\;"
    hour "10"
    minute "0"
  end
end
