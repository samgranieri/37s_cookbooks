package "nginx"

service "nginx" do
  action :enable
  supports :restart => true, :reload => true
end

service "nginx" do
  action :start
end