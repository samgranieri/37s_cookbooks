define :bluepill_monitor, :enable => true do
  include_recipe "bluepill"
  config_path = "/etc/bluepill/conf.d/#{params[:name]}.conf.rb"

  execute "load-bluepill-#{params[:name]}" do
    command "bluepill load #{node[:bluepill][:config_path]}/#{params[:name]}.conf.rb"
    action :nothing
  end

  template config_path do
    source params[:source] || "bluepill_#{params[:name]}.conf.erb"
    cookbook params[:cookbook]
    variables params
    notifies :restart, resources(:service => "bluepill")
  end

end