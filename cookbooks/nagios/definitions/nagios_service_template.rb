define :nagios_template, :template_type => "service" do
  template_type = params[:template_type]
  params.delete(:template_type)
  node[:nagios][:templates]["#{params[:name]}-#{template_type}"] = params
end