if node[:rails][:delayed_jobs]
  node[:rails][:delayed_jobs].each do |j|
    runit_service "dj-worker-#{j[:name]}"
    template_name "dj-worker"
    cookbook "rails"
    variables :command_line => j[:command_line]
  end
end
