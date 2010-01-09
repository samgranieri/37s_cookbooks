gem_package "unicorn" do
  version node[:unicorn][:version]
end

directory "/etc/unicorn" do
  owner "app"
  group "app"
  mode 0755
end

directory "/tmp/unicorn" do
  owner "app"
  group "app"
  mode 0755
end