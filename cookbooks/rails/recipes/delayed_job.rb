if node[:active_applications]

  node[:active_applications].each do |app, conf|

    if node[:applications][app][:delayed_job]
      god_monitor "delayed_job" do
        source "delayed_job.conf.erb"
        cookbook "rails"
        rails_env conf[:env]
        rails_root "/u/apps/#{app}/current"
        interval 30
        user "app"
        group "app"
        memory_limit 500 # megabytes
        cpu_limit 50 # percent
      end

    end  
  end
end