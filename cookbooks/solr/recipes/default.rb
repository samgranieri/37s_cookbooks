
require_recipe "tomcat"

node[:active_applications].keys.each do |app|
  template "/etc/tomcat6/Catalina/localhost/#{app}.xml" do
    source "solr.xml.erb"
    variables(:app => app)
    owner node[:tomcat][:user]
    mode "0644"
    backup false

    notifies :restart, resources("service[tomcat6]"), :delayed
  end

  directory "#{node[:solr][:root]}/#{app}" do
    recursive true
    owner "app"
    group "app"
    mode 0755
  end

  
  remote_directory "#{node[:solr][:root]}/#{app}/bin" do
    source node[:solr][:script_dir]
    owner "app"
    group "app"
    mode 0750
    files_owner "app"
    files_group "app"
    files_mode 0700
  end
  
  directory "#{node[:solr][:root]}/#{app}/data" do
    owner "app"
    group "app"
    mode 0755
  end

  if node[:solr][:data_device]
    mount "#{node[:solr][:root]}/#{app}/data" do
      device node[:solr][:data_device]
      fstype "ext3"
      action [ :enable, :mount ]
    end
  end

  remote_file "#{node[:solr][:root]}/#{app}/#{node[:solr][:war][:file]}" do
    source "#{node[:solr][:war][:url]}/#{node[:solr][:war][:file]}"
    owner "app"
    group "app"
    mode 0644
  end
end
