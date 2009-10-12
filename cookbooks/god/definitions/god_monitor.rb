define :god_monitor, :enable => true do
  include_recipe "god"
  filename = "/etc/god/conf.d/#{params[:name]}.conf.rb"
  
  if params[:enable]
    if params[:config_path]
      link filename do
        to params[:config_path]
        only_if { File.exists?(params[:config_path]) }
        notifies :restart, resources(:service => "god")
      end
    end
  else
    file filename do
      action :delete
      only_if { File.symlink?("/etc/god/conf.d/#{params[:name]}") }
      notifies :restart, resources(:service => "god")
    end
  end
end