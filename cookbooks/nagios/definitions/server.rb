define :nagios_conf, :variables => {}, :config_subdir => true do
  
  subdir = if params[:config_subdir]
    "/#{node[:nagios][:config_subdir]}/"
  else
    "/"
  end
  
  template "#{node[:nagios][:root]}#{subdir}#{params[:name]}.cfg" do
    owner "nagios"
    group "nagios"
    source "#{params[:name]}.cfg.erb"
    mode 0644
    variables params[:variables]
    notifies :restart, resources(:service => "nagios3")
  end
end

define :nagios_service_template do
  node[:nagios][:service_templates]["#{params[:name]}-service"] = params
end