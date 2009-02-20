define :passenger_app do
  subdir = (params[:conf][:env] == "staging") ? "staging/" : ""
  root = "/u/#{subdir}apps/#{params[:name]}/current"
  full_name = "#{params[:name]}_#{params[:conf][:env]}"
  
  template "/etc/apache2/sites-available/#{full_name}" do
    owner 'root'
    group 'root'
    mode 0644
    source "passenger.vhost.erb"
    variables({
      :name => full_name,
      :docroot  => docroot,
      :server_name  => params[:conf][:server_name],
      :max_pool_size    => params[:conf][:max_pool_size] || 4,
      :ssl => params[:conf][:ssl],
      :env => params[:conf][:env]
    })
    #only_if { File.exists?(docroot) }
  end

  link "#{root}/config/apache/#{params[:conf][:env]}.conf" do
    to "#{node[:apache][:dir]}/sites-available/#{full_name}"
  end
  
  enable_setting = params[:conf][:enable]
  
  apache_site full_name do
    enable enable_setting
    only_if { File.exists?("/etc/apache2/sites-available/#{full_name}") }
  end
end