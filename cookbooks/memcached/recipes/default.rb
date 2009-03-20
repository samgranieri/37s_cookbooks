package "memcached"

service "memcached" do
  action :enable
  supports :restart => true, :reload => true
end

template node[:memcached][:conf_path] do
  source "memcached.conf.erb"  
  notifies :restart, resources(:service => "memcached")
end

service "memcached" do
  action :start
end
