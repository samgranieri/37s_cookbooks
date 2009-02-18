define :nagios_service_template do
  node[:nagios][:service_templates]["#{params[:name]}-service"] = params
end