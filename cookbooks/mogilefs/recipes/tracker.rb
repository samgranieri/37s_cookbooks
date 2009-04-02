
require_recipe "mogilefs"

template "#{node[:mogilefs][:path]}/etc/mogilefsd.conf" do
  source "mogilefsd.conf.erb"
  owner "app"
  mode 0600
end

