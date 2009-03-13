package "memcached"

service "memcached" do
  action [:enable, :start]
  supports :restart => true, :reload => true
end
