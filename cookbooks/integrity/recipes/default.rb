
require_recipe "passenger"

gem_package "imbriaco-integrity" do
  source "http://gems.github.com"
end

gem_package "defunkt-integrity-campfire" do
  source "http://gems.github.com"
end
  
gem_package "do_sqlite3"
gem_package "do_mysql"
gem_package "mocha"
gem_package "tinder"

if node[:integrity][:projects]
  node[:integrity][:projects].each do |app|
    if node[:applications][app][:gems]
      node[:applications][app][:gems].each do |g|
        if g.is_a? Array
          gem_package g.first do
            version g.last
          end
        else
          gem_package g
        end
      end
    end
    
    if node[:applications][app][:packages]
      node[:applications][app][:packages].each do |package_name|
        package package_name
      end      
    end
    
    if node[:applications][app][:symlinks]
      node[:applications][app][:symlinks].each do |target, source|
        link target do
          to source
        end
      end      
    end
  end
end

directory "/u/apps" do
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

logrotate "integrity" do
  files "#{node[:integrity][:path]}/log/*.log"
  frequency "weekly"
  restart_command "/etc/init.d/apache2 reload > /dev/null"
end
