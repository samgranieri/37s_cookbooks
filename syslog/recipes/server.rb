require_recipe "syslog"
require_recipe "logsort"

apps = search(:apps)

template "/etc/syslog-ng/syslog-ng.conf" do
  source "syslog-ng-server.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "syslog-ng")
  variables(:apps => apps)
end

directory node[:syslog_ng][:root] do
  owner "root"
  group "admin" 
end

remote_file "/usr/local/bin/logsort" do
  source "logsort"
  mode 0755
end

if !apps.empty?
  apps.each do |app|
    directory node[:syslog_ng][:root] + "/#{app[:id]}" do
      owner "app"
      group "app"
      mode 0750
    end
  end
  logrotate "applications" do
    restart_command "/etc/init.d/syslog-ng reload 2>&1 || true"
    files apps.collect{|a| root+"/#{a[:id]}/*.log" }
    frequency "daily"
  end
end

directory node[:syslog_ng][:root] + "/syslog" do
  owner "root"
  group "app"
  mode 0750
  recursive true
end

logrotate "syslog-remote" do
  restart_command "/etc/init.d/syslog-ng reload 2>&1 || true"
  files ['/u/logs/syslog/messages', "/u/logs/syslog/secure", "/u/logs/syslog/maillog", "/u/logs/syslog/cron", "/u/logs/syslog/bluepill"]
end

apps.each do |app|
  next unless !app.to_hash[:syslog_files].nil? && app.to_hash[:syslog_files][:logsort]
  
  cron "logsort log rotation: #{app[:id]}" do
    command "find /u/logs/#{app[:id]} -maxdepth 1 -type d -mtime +5 -exec rm -rf {} \\;"
    hour "10"
    minute "0"
  end
end