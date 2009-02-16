require_recipe "apt"

directory node[:apt][:base_path] do
  action :create
  owner "root"
  group "root"
  mode 0755
end

%(var skel mirror).each do |dir|
  directory node[:apt][:base_path]+"/#{dir}" do
    action :create
    owner "root"
    group "root"
    mode 0755
  end
end

template "/etc/apt/mirror.list" do
  source "apt-mirror.list.erb"
  mode 0644  
end

cron "apt mirror nightly update" do
  command "/usr/bin/apt-mirror > /var/log/apt-mirror.log 2>&1"
  hour 5
  only_if File.exist?(node[:apt][:base_path]+"/mirror")
end

