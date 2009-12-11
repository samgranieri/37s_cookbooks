# Only setup Unicorn when the rails[:app_server] is set to unicorn
return unless node[:rails][:app_server] == 'unicorn'

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