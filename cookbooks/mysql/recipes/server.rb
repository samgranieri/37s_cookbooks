package "mysql-server"

service "mysql" do
  action :enable
  supports [:restart, :reload]
end

directory node[:mysql][:server][:root] do
  owner "mysql"
  group "mysql"
end

directory node[:mysql][:server][:datadir] do
  owner "mysql"
  group "mysql"
end

directory node[:mysql][:server][:log_root] do
  owner "mysql"
  group "mysql"  
end

directory node[:mysql][:server][:binlog_dir] do
  owner "mysql"
  group "mysql"  
end

template "/etc/mysql/my.cnf" do
  source "mysql.cnf.erb"
  notifies :reload, resources(:service => "mysql")
end

execute "Initiilize mysql database" do
  command "mysql_install_db --user=mysql"
  creates "#{node[:mysql][:server][:datadir]}/mysql"
end

service "mysql" do
  action :start
end