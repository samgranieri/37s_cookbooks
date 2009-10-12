include_recipe "ruby"
include_recipe "runit"

gem_package "god" do
  version node[:god][:version]
end

directory "/etc/god/conf.d" do
  recursive true
  owner "root"
  group "root"
  mode 0755
end

template "/etc/god/master.god" do
  source "master.god.erb"
  owner "root"
  group "root"
  mode 0755
end

runit_service "god"