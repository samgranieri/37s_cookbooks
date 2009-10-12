define :god_monitor, :enable => true do
  include_recipe "god"

  if params[:enable]
    if params[:config_path]
      link "/etc/god/conf.d/#{params[:name]}" do
        to params[:config_path]
        only_if { File.exists?(params[:config_path]) }
      end
    end
  else
    file "/etc/god/conf.d/#{params[:name]}" do
      action :delete
      only_if { File.symlink?("/etc/god/conf.d/#{params[:name]}") }
    end
  end
end