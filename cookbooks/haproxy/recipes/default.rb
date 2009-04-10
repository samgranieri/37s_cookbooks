
package "haproxy" do
  action :install
end

directory "/etc/haproxy" do
  action :create
  owner "root"
  group "root"
  mode 0755
end

directory "/var/log/haproxy" do
  action :create
  owner node[:haproxy][:user]
  group node[:haproxy][:user]
  mode 0750
end

remote_file "/etc/init.d/haproxy" do
  source "haproxy.init"
  owner "root"
  group "root"
  mode 0700
end

node[:haproxy][:instances].each do |instance|
  template "/etc/haproxy/#{instance[:name]}.cfg" do
    source "haproxy.cfg.erb"
    variables(:instance => instance)
    owner node[:haproxy][:user]
    group node[:haproxy][:group]
    mode 0640
    notifies :reload, resources(:service => "haproxy_#{instance[:name]}")
  end

  service "haproxy_#{instance[:name]}" do
    pattern "haproxy.*#{instance[:name]}"
    running :true
    
    start_command   "start #{instance[:name]}"
    stop_command    "stop #{instance[:name]} #{instance[:pid_file]}"
    restart_command "restart #{instance[:name]} #{instance[:pid_file]}"
    reload_command  "reload #{instance[:name]} #{instance[:pid_file]}"
    
    supports [ :start, :stop, :restart, :reload ]
  end
end
