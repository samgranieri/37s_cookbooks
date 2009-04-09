
package "keepalived"

directory File.dirname(node[:keepalived][:config_path]) do
  owner "root"
  group "root"
end

template node[:keepalived][:config_path] do 
  source "keepalived.conf.erb"
  owner "root"
  group "root"
  mode 0400
end

service "keepalived"
