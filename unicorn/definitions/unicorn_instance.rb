define :unicorn_instance, :enable => true do

  template params[:conf_path] do
    source "unicorn.conf.erb"
    cookbook "unicorn"
    variables params
  end

  bluepill_monitor app do
    cookbook 'unicorn'
    source "bluepill.conf.erb"
    env params[:env]
    root params[:root]
    preload params[:preload]
    interval params[:interval]
    user params[:user]
    group params[:group]
    memory_limit params[:memory_limit]
    cpu_limit params[:cpu_limit]
    rack_config_path params[:rack_config_path]
  end

end