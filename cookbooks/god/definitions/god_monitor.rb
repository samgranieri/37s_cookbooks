define :god_monitor, :enable => true do
  include_recipe "god"
  symlink_path = "/etc/god/conf.d/#{params[:name]}.conf.rb"
  
  if params[:enable]
    if params[:config_path]
      link symlink_path do
        to params[:config_path]
        only_if { File.exists?(params[:config_path]) }
        notifies :restart, resources(:service => "god")
      end
    end
  else
    file symlink_path do
      action :delete
      only_if { File.symlink?(symlink_path) }
      notifies :restart, resources(:service => "god")
    end
  end
end