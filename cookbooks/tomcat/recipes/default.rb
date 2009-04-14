
require_recipe "java"

return unless ["ubuntu", "debian"].include?(node[:platform])

package "tomcat6"
service "tomcat6"

template "/etc/default/tomcat6" do
  source "default.tomcat6.erb"
  owner "root"
  group "root"
  mode 0644
  
  notifies :restart, resources(:service => "tomcat6")
end
