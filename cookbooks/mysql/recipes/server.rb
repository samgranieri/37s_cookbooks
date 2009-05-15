package "mysql-server"

service "mysql" do
  action :enable
  supports [:restart, :reload]
end

directory mysql[:server][:root] do
  owner "mysql"
  group "mysql"
end

directory mysql[:server][:log_root] do
  owner "mysql"
  group "mysql"  
end

directory mysql[:server][:binlog_dir] do
  owner "mysql"
  group "mysql"  
end

template "/etc/mysql/my.cnf" do
  source "mysql.cnf.erb"
  notifies :reload, resources(:service => "mysql")
end

service "mysql" do
  action :start
end