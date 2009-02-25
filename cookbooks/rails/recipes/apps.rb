require_recipe "passenger"

directory "/u/apps" do
  action :create
  owner "app"
  group "app"
  mode 0775
end

directory "/u/logs" do
  action :create
  mode 0755
  owner "app"
  group "app"
end

directory "/u/logs/apps" do
  action :create
  mode 0775
  owner "app"
  group "www-data"
end

node[:applications].each do |app, conf|
  full_name = "#{app}_#{conf[:env]}"
  config_path = "/u/apps/#{app}/current/config/apache/#{conf[:env]}.conf"
  
  if conf[:gems]
    conf[:gems].each do |gem_name|
      gem_package gem_name
    end
  end
  
  link "/etc/apache2/sites-available/#{full_name}" do
    to config_path
    only_if { File.exists?(config_path) }
  end
  apache_site full_name do
    only_if { File.exists?("/etc/apache2/sites-available/#{full_name}") }
  end
end