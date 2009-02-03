define :nagios_conf, :variables => {} do
  include_recipe "nagios::server"
  nagios_root = "/etc/nagios3/"
  
  template "#{node[:nagios][:root]}/#{params[:name]}.cfg" do
    owner "nagios"
    group "nagios"
    source "#{params[:name]}.cfg.erb"
    mode 0440
    variables params[:variables]
    notifies :restart, resources(:service => "nagios3")
  end
end