
package "keepalived" do
  action :install
end

template node[:keepalived][:config_path] do 
  source "keepalived.conf.erb"
  owner "root"
  group "root"
  mode 0400
  notifies :reload, resources(:service => "keepalived")
end

service "keepalived" do
  supports :restart => true
  action [:enable, :start]
end
