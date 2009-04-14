
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

execute "fix_permissions" do
  command "chown -R #{node[:tomcat][:user]}:admin /etc/tomcat6 && touch /etc/tomcat6/perms.ok"
  creates "/etc/tomcat6/perms.ok"
end  

directory "/var/log/tomcat6" do
  owner node[:tomcat][:user]
  group "admin"
  mode 0750
end

directory "/var/lib/tomcat6" do
  owner node[:tomcat][:user]
  group "admin"
  mode 0750
end

[ "lib", "temp", "webapps" ].each do |dir|
  directory "/var/lib/tomcat6/#{dir}" do
    owner node[:tomcat][:user]
    group "admin"
    mode 0750
  end
end
