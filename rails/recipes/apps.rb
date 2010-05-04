require_recipe "rails::app_dependencies"
require_recipe "unicorn"

if node[:active_applications]
  node[:active_applications].each do |name, conf|
    
    app = search(:apps, "id:#{name}").first
    app_name = conf[:app_name] || name
    
    Chef::Log.info "Setting up Rails app #{name}"

    full_name = "#{name}_#{conf[:env]}"
    filename = "#{conf[:env]}.conf"
    path = "/u/apps/#{name}/current/config/nginx/#{filename}"
    
    if !conf[:app_only]
      nginx_site full_name do
        config_path path
        only_if { File.exists?("/etc/nginx/sites-available/#{full_name}") }
      end
      
      if app[:domains]
        app[:domains].each do |domain|
          ssl_certificate domain
        end
      end
    end
    
    logrotate full_name do
      files "/u/apps/#{name}/current/log/*.log"
      frequency "daily"
      rotate_count 14
      compress true
      restart_command "/etc/init.d/nginx reload > /dev/null"
    end

    bluepill_monitor full_name do
      cookbook "unicorn"
      source "bluepill.conf.erb"
      env conf[:env]
      app_root "/u/apps/#{name}/current"
      preload !app[:preload].nil? ? app[:preload] : true
      interval 30
      user "app"
      group "app"
      memory_limit 250 # megabytes
      cpu_limit 50 # percent
      rack_config_path "/u/apps/#{name}/current/config.ru" if app[:rack_config]
      use_bundler !app[:use_bundler].nil? ? app[:use_bundler] : false
    end
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end