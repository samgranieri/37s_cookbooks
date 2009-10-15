require_recipe "rails::app_dependencies"

require_recipe node[:rails][:app_server]
web_server = node[:rails][:web_server]

if node[:active_applications]

  node[:active_applications].each do |app, conf|

    full_name = "#{app}_#{conf[:env]}"
    filename = "#{conf[:env]}.conf"
    path = "/u/apps/#{app}/current/config/#{web_server}/#{filename}.conf.rb"

    if node[:applications][app]
      if modules = node[:applications][app]["#{web_server}_modules"]
        modules.each do |mod|
          if web_server == "apache2"
            require_recipe "apache2::mod_#{mod}"
            apache_module mod
          else
            # install nginx modules
          end
        end
      end
    end

    send("#{web_server}_site".to_sym, full_name) do
      config_path path
      only_if { File.exists?("/etc/#{web_server}/sites-available/#{full_name}") }
    end

    logrotate full_name do
      files "/u/apps/#{app}/current/log/*.log"
      frequency "daily"
      rotate_count 14
      compress true
      restart_command "/etc/init.d/#{web_server} reload > /dev/null"
    end

    if node[:rails][:app_server] == "unicorn"
      god_monitor app do
        cookbook "unicorn"
        rails_env conf[:env]
        rails_root "/u/apps/#{app}/current"
        interval 30
        user "app"
        group "app"
        memory_limit 250 # megabytes
        cpu_limit 50 # percent
      end
    end
    
    if node[:applications][app][:domains]
      node[:applications][app][:domains].each do |domain|
        ssl_certificate node.role?("staging") ? "staging.#{domain}" : domain
      end
    end
    
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end