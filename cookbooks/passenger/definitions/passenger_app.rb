define :passenger_app do
  
  subdir = (params[:config][:env] == :staging) ? "staging/" : ""
  docroot = "/u/apps/#{subdir}#{params[:name]}/current/public"
  
  template "/etc/apache2/sites-available/#{params[:name]}_#{params[:config][:env]}" do
    owner 'root'
    group 'root'
    mode 0644
    source "application.vhost.erb"
    variables({
      :name => params[:name],
      :docroot  => docroot,
      :server_name  => params[:config][:server_name],
      :max_pool_size    => params[:config][:max_pool_size] || 4
    })
    only_if { File.exists?(docroot) }
  end
  
  apache_site "#{params[:name]}_#{params[:config][:env]}" do
    enable params[:config][:enable]
    only_if { File.exists?("/etc/apache2/sites-available/#{params[:name]}_#{params[:config][:env]}") }
  end
end