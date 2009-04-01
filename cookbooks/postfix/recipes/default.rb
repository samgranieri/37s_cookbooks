package "postfix" do
  action :upgrade
end

template "/etc/postfix.main.cf" do
  source "main.cf.erb"
end

service "postfix" do
  action [:enable, :start]
  supports :restart => true, :reload => true
end