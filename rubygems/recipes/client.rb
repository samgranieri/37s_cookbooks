template "/etc/gemrc" do
  source "gemrc.erb"
  mode 0644
end

execute "update rubygems" do
  command "gem update --system"
  not_if { `gem -v`.chomp == node[:rubygems][:version] }
end

gem_package "bundler" do
  version node[:rubygems][:bundler_version] = "0.8.1"
end