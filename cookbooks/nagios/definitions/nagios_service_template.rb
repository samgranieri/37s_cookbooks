define :nagios_template, :type => "service" do
  type = params[:type]
  params.delete(:type)
  node[:nagios][:templates]["#{params[:name]}-#{type}"] = params
end