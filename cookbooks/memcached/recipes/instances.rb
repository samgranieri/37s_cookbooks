require_recipe "memcached"
include_recipe "runit"

service "memcached" do
  action [:stop, :disable]
end

if node[:memcached][:instances]
  node[:memcached][:instances].each do |name, instance|
  
    runit_service "memcached-#{name}" do
      template_name "memcached"
      cookbook "memcached"
      options({"max_memory" => node[:memcached][:max_memory],
               "port" => node[:memcached][:port], "user" => node[:memcached][:user],
               "max_connections" => node[:memcached][:max_connections]}.merge(instance))
    end

    service "memcached-#{name}" do
      action [:enable, :start]
    end
  end
end