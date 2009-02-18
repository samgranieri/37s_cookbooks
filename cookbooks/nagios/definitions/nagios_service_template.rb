define :nagios_servicetemplate do
  node[:nagios][:service_templates]["#{params[:name]}-service"] = params
end