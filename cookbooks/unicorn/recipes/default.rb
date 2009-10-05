gem_package "unicorn" do
  action :upgrade
  version node[:unicorn][:version]
end

directory "/etc/unicorn" do
  owner "app"
  group "app"
  mode 0755
end

directory "/tmp/unicorn" do
  owner "app"
  group "app"
  mode 0755
end

counter = 0
node[:active_applications].each do |name, config|
  
  defaults = Mash.new({
    :pid_path => "/tmp/unicorn/#{name}.pid",
    :worker_count => node[:unicorn][:worker_count],      
    :timeout => node[:unicorn][:timeout],
    :socket_path => "/tmp/unicorn/#{name}.sock",
    :backlog_limit => 1,
    :master_bind_address => '0.0.0.0',
    :master_bind_port => "37#{counter}00",
    :worker_listeners => true,
    :worker_bind_address => '127.0.0.1',
    :worker_bind_base_port => "37#{counter}01",
    :debug => false,
    :binary_path => config[:rack_only] ? "#{node[:ruby_bin_path]}/unicorn" : "#{node[:ruby_bin_path]}/unicorn_rails",
    :env => 'production',
    :app_path => "/u/apps/#{name}/current",
    :enable => true,
    :config_path => "/etc/unicorn/#{name}.conf"
  })
  
  config = defaults.merge(config)
  
  runit_service "unicorn-#{name}" do
    template_name "unicorn"
    cookbook "unicorn"
    options config
  end
    
  template "/etc/unicorn/#{name}.conf" do
    source "unicorn.conf.erb"
    variables config
    notifies :restart, resources(:service => "unicorn-#{name}")
  end
    
  service "unicorn-#{name}" do
    action config[:enable] ? [:enable, :start] : [:disable, :stop]
  end

  counter += 1
end