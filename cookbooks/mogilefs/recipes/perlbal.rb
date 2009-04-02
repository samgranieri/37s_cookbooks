
require_recipe "mogilefs"

template "#{node[:mogilefs][:path]}/etc/perlbal.conf" do
  source "perlbal.conf.erb"
  owner "app"
  group "app"
  mode 0644
end

