require_recipe "aws"
require_recipe "bundler"

gem_package "rack" do
  version "1.0.1"
end

gem_package "system_timer"


if node[:active_applications]

  node[:active_applications].each do |name, conf|

    app = search(:apps, "id:#{name}").first

    app_name = conf[:app_name] || name

    directory "/u/apps/#{name}/shared/config" do
      recursive true
      owner "app"
      group "app"
    end
    
    if app[:packages]
      app[:packages].each do |package_name|
        package package_name
      end      
    end
    
    if app
      if app[:gems]
        app[:gems].each do |g|
          if g.is_a? Array
            gem_package g.first do
              version g.last
            end
          else
            gem_package g
          end
        end
      end
    
      if app[:symlinks]
        app[:symlinks].each do |target, source|
          link target do
            to source
          end
        end
      end
      
      if app[:domains]
        app[:domains].each do |domain|
          ssl_certificate domain
        end
      end
      
      if app[:aws]
        
        s3_bucket = app[:aws][:s3] ? app[:aws][:s3][:bucket] : "#{name}-#{conf[:env]}"
        
        template "/u/apps/#{name}/shared/config/s3.yml" do
          source "s3.yml.erb"
          mode "0640"
          cookbook "aws"
          backup false
          variables(:aki => app[:aws][:aki], :sak => app[:aws][:sak], :s3_bucket => s3_bucket)
          owner "root"
          group "app"
        end
        
      end
      
    end
  end
else
  Chef::Log.info "Add an :active_applications attribute to configure this node's apps"
end
