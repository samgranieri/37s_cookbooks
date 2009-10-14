define :god_monitor, :enable => true do
  include_recipe "god"
  config_path = "/etc/god/conf.d/#{params[:name]}.conf.rb"

  template config_path do
    variables params
    notifies :restart, resources(:service => "god")
  end

end