define :logrotate, :frequency => "daily", :enable => true do
  template "/etc/logrotate.d/#{params[:name]}" do
    action (params[:enable] ? :create : :delete)
    cookbook "logrotate"
    source "logrotate.conf.erb"
    variables(:files => params[:files], :frequency => params[:frequency], :restart_command => params[:restart_command])
  end
end