package "memcached"

service "memcached" do
  action :enable
  supports :restart => true, :reload => true
end

%w(libevent1_1.4.9-1ubuntu1_amd64.deb memcached_1.2.6-1ubuntu2_amd64.deb).each do |f|
  remote_file "/tmp/#{f}" do
    source f
  end
  execute "install #{f}" do
    code "dpkg -i /tmp/#{f}"
    not_if "dpkg -l | grep #{f.match(/.+-(.+).deb/)[1]} | grep ii"
  end
end

template node[:memcached][:conf_path] do
  source "memcached.conf.erb"  
  notifies :restart, resources(:service => "memcached")
end

service "memcached" do
  action :start
end
