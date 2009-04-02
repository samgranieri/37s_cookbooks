
require_recipe "mogilefs"

template "#{node[:mogilefs][:path]}/etc/mogstored.conf" do
  source "mogstored.conf.erb"
  owner "root"
  mode 0644
end

directory "#{node[:mogilefs][:mogstored][:doc_root]}" do
  owner "app"
  group "app"
  mode 0755
end

