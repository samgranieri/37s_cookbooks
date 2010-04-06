require_recipe "rails::app_dependencies"

require_recipe node[:rails][:app_server]
web_server = node[:rails][:web_server]
system_web_server = web_server == 'apache' ? 'apache2' : web_server

if node[:active_applications]
  node[:active_applications].each do |app, conf|

    Chef::Log.info "Setting up Rails app #{app}"

    full_name = "#{app}_#{conf[:env]}"
    filename = "#{conf[:env]}.conf"
    path = "/u/apps/#{app}/current/config/#{web_server}/#{filename}"
    app_name = conf[:app_name] || app

    if node[:applications][app_name]
      if modules = node[:applications][app_name]["#{web_server}_modules"]
        modules.each do |mod|
          if web_server == "apache"
            require_recipe "apache2::mod_#{mod}"
            apache_module mod
          else
            # install nginx modules
          end
        end
      end
    end

    if !conf[:app_only]
      send("#{web_server}_site".to_sym, full_name) do
        config_path path
        only_if { File.exists?("/etc/#{system_web_server}/sites-available/#{full_name}") }
      end
      
      if node[:applications][app_name][:domains]
        node[:applications][app_name][:domains].each do |domain|
          ssl_certificate domain
        end
      end
    end
    
    logrotate full_name do
      files "/u/apps/#{app}/current/log/*.log"
      frequency "daily"
      rotate_count 14
      compress true
      restart_command "/etc/init.d/#{system_web_server} reload > /dev/null"
    end

    if node[:rails][:app_server] !~ /passenger/
      bluepill_monitor app do
        cookbook node[:rails][:app_server]
        source "bluepill.conf.erb"
        env conf[:env]
        app_root "/u/apps/#{app}/current"
        preload !node[:applications][app_name][:preload].nil? ? node[:applications][app_name][:preload] : true
        interval 30
        user "app"
        group "app"
        memory_limit 250 # megabytes
        cpu_limit 50 # percent
        rack_config_path "/u/apps/#{app}/current/config.ru" if node[:applications][app_name][:rack_config]
        use_bundler !node[:applications][app_name][:use_bundler].nil? ? node[:applications][app_name][:use_bundler] : false
      end
    end
    
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end
