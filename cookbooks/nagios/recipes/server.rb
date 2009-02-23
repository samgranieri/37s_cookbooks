include_recipe "apache2"

package "nagios" do
  package_name 'nagios3'
  action :install
end

file "/etc/nagios3/htpasswd.users" do
  owner "nagios"
  group "www-data"
  mode 0750
  action :create
end

# using the node object inside this block fails, so we assign for now
userlist = node[:nagios][:users]

add_htpasswd_users "/etc/nagios3/htpasswd.users" do
  users userlist
end

hosts = []
search(:node, "*") {|n| hosts << n }

service "nagios3" do
  supports :status => true, :restart => true, :reload => true
  action :enable
end

nagios_conf "nagios" do
  config_subdir false
end

directory "#{node[:nagios][:root]}/dist" do
  owner "nagios"
  group "nagios"
  mode 0755
end

%(templates contacts commands).each do |dir|
  directory "#{node[:nagios][:root]}/conf.d/#{dir}" do
    owner "nagios"
    group "nagios"
    mode 0755
  end
end

execute "archive default nagios object definitions" do
  command "mv #{node[:nagios][:root]}/conf.d/*_nagios*.cfg #{node[:nagios][:root]}/dist"
  not_if { Dir.glob(node[:nagios][:root] + "/conf.d/*_nagios*.cfg").empty? }
end

remote_directory "/var/lib/nagios/notifiers" do
  source "notifiers"
  files_backup 5
  files_owner "nagios"
  files_group "nagios"
  files_mode 0644
  owner "nagios"
  group "nagios"
  mode 0755
end

nagios_conf "commands"
nagios_conf "contacts"
nagios_conf "templates"
nagios_conf "timeperiods"

nagios_conf "hosts" do
  variables({:hosts => hosts})
end

nagios_service_template "local" do
  max_check_attempts      4
  normal_check_interval   300
  retry_check_interval    60
end

service "nagios3" do
  action :start
end