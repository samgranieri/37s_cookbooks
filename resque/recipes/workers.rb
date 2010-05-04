require_recipe "resque"

node[:resque][:workers].each do |name, conf|
  bluepill_monitor name do
    cookbook "resque"
    source "bluepill.conf.erb"
    worker_count conf[:count]
    env_vars conf[:env_vars]
    log_path conf[:log_path] || "/tmp/bluepill_stdout.log"
    working_dir conf[:working_dir]
    interval 1
    user "app"
    group "app"
    memory_limit 250 # megabytes
    cpu_limit 50 # percent
  end
end