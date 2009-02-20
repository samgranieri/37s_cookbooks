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

Dir.open("/u/apps").entries.each do |app|
  %w(staging production).each do |role|
    if node[:applications][app] && node[:applications][app][role]
      full_name = "#{app}_#{role}"
      config_path = "/u/apps/#{app}/current/config/apache/#{role}.conf"      
      link config_path do
        to "/etc/apache2/sites-available/#{full_name}"
        only_if { File.exists?(config_path) }
      end  
      apache_site full_name do
        only_if { File.exists?("/etc/apache2/sites-available/#{full_name}") }
      end
    end
  end
end