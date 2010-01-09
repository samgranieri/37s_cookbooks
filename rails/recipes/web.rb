# TODO: consolidate this recipe and app_dependencies

web_server = node[:web_server]
system_web_server = web_server == 'apache' ? 'apache2' : web_server

if node[:active_applications]

  node[:active_applications].each do |app, conf|
    full_name = "#{app}_#{conf[:env]}"
    filename = "#{conf[:env]}_web.conf"
    path = "/u/apps/#{app}/current/config/#{system_web_server}/#{filename}"
    
    if system_web_server == "apache"
      if modules = node[:applications][app][:apache_modules]
        modules.each do |mod|
          require_recipe "apache2::mod_#{mod}"
          apache_module mod
        end
      end
    end
    
    if node[:applications][app][:domains]
      node[:applications][app][:domains].each do |domain|
        ssl_certificate domain
      end
    end
    
    send("#{web_server}_site".to_sym, full_name) do
      config_path path
      only_if { File.exists?("/etc/#{system_web_server}/sites-available/#{full_name}") }
    end
    
    logrotate full_name do
      files "/u/apps/#{app}/current/log/*.log"
      frequency "daily"
      rotate_count 14
      compress true
      restart_command "/etc/init.d/#{system_web_server} reload > /dev/null"
    end
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end