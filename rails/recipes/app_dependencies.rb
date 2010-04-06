require_recipe "aws"
require_recipe "bundler"

directory "/u/apps" do
  owner "app"
  group "app"
  mode 02775
  recursive true
end

gem_package "rack" do
  version "1.0.1"
end

gem_package "system_timer"

if node[:active_applications]

  node[:active_applications].each do |app, conf|

    app_name = conf[:app_name] || app

    directory "/u/apps/#{app}/shared/config" do
      recursive true
      owner "app"
      group "app"
    end
    
    if node[:applications][app_name][:packages]
      node[:applications][app_name][:packages].each do |package_name|
        package package_name
      end      
    end
    
    if node[:applications][app_name]
      if node[:applications][app_name][:gems]
        node[:applications][app_name][:gems].each do |g|
          if g.is_a? Array
            gem_package g.first do
              version g.last
            end
          else
            gem_package g
          end
        end
      end
    
      if node[:applications][app_name][:symlinks]
        node[:applications][app_name][:symlinks].each do |target, source|
          link target do
            to source
          end
        end
      end
      
      if node[:applications][app_name][:domains]
        node[:applications][app_name][:domains].each do |domain|
          ssl_certificate domain
        end
      end
      
      if node[:applications][app_name][:aws]
        
        s3_bucket = node[:applications][app_name][:aws][:s3] ? node[:applications][app_name][:aws][:s3][:bucket] : "#{app}-#{conf[:env]}"
        
        template "/u/apps/#{app}/shared/config/s3.yml" do
          source "s3.yml.erb"
          mode "0640"
          cookbook "aws"
          backup false
          variables(:aki => node[:applications][app_name][:aws][:aki], :sak => node[:applications][app_name][:aws][:sak], :s3_bucket => s3_bucket)
          owner "root"
          group "app"
        end
        
      end
      
    end
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end
