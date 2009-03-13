package "nginx"

service "nginx" do
  action :enable
  supports :restart => true, :reload => true
end

file "/etc/nginx/sites-available/default" do
  action :delete
end

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

service "nginx" do
  action :start
end