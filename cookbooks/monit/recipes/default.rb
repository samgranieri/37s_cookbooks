package "monit" do
  action :install
end

template "/etc/monitrc" do
  owner "root"
  group "root"
  mode 0700
  source 'monitrc.erb'
end

execute "restart-monit" do
  command "pkill -9 monit && monit"
  action :nothing
end

