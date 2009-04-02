
require_recipe "mogilefs"

template "#{node[:mogilefs][:path]}/etc/mogstored.conf" do
  source "mogstored.conf.erb"
  owner "root"
  mode 0644
end

