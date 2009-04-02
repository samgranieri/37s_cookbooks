
gem_package "defunkt-integrity-campfire" do
  source "http://gems.github.com"
end

directory "/u/apps/integrity" do
  owner "app"
  group "app"
  mode 0755
end

execute "setup_integrity" do
  command "integrity install #{node[:integrity][:path]} --passenger"
  user "app"
  group "app"
  not_if "test -e /u/apps/integrity"
end

template "#{node[:integrity][:path]}/config.ru" do
  source "config.ru.erb"
  owner "app"
  group "app"
  mode 0644
end

template "#{node[:integrity][:path]}/config.yml" do
  source "config.yml.erb"
  owner "app"
  group "app"
  mode 0644
end

