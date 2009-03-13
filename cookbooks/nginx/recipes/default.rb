package "nginx"

service "nginx" do
  action :enable
  supports :restart => true, :reload => true
end

file "/etc/nginx/sites-available/default" do
  action :remove
end

file "/etc/nginx/sites-enabled/default" do
  action :remove
end

service "nginx" do
  action :start
end