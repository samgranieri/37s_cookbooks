
require_recipe "passenger"

gem_package "integrity"
gem_package "do_sqlite3"
gem_package "defunkt-integrity-campfire" do
  source "http://gems.github.com"
end

directory "/u/apps/integrity" do
  owner "app"
  group "app"
  mode 0755
  recursive true
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

template "#{node[:integrity][:path]}/vhost.conf" do
  source "vhost.conf.erb"
  owner "app"
  group "app"
  mode 0644
end

apache_site "integrity" do
  config_path "#{node[:integrity][:path]}/vhost.conf"
  not_if { File.exists?("/etc/apache2/sites-enabled/integrity") }
end

logrotate full_name do
  files "#{node[:integrity][:path]}/log/*.log"
  frequency "weekly"
  restart_command "/etc/init.d/apache2 reload > /dev/null"
end
