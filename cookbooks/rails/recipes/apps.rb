require_recipe "rails::app_dependencies"
require_recipe "passenger"

if node[:active_applications]

  node[:active_applications].each do |app, conf|
    full_name = "#{app}_#{conf[:env]}"
    filename = "#{conf[:env]}.conf"
    path = "/u/apps/#{app}/current/config/apache/#{filename}"
    
    if modules = node[:applications][app][:apache_modules]
      modules.each do |mod|
        require_recipe "apache2::mod_#{mod}"
        apache_module mod
      end
    end
    
    apache_site full_name do
      config_path path
      only_if { File.exists?("/etc/apache2/sites-available/#{full_name}") }
    end

    logrotate full_name do
      files "/u/apps/#{app}/current/log/*.log"
      frequency "weekly"
      restart_command "/etc/init.d/apache2 reload > /dev/null"
    end
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end