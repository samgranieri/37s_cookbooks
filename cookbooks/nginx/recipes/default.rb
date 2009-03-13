package "nginx"

file "/etc/nginx/sites-available/default" do
  action :remove
end

file "/etc/nginx/sites-enabled/default" do
  action :remove
end