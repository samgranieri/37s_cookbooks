service "ssh" do
  supports :restart => true, :reload => true
  action :enable
end

remote_file "/etc/ssh/known_hosts" do
  source "known_hosts"
  mode 0644
end

template "/etc/ssh/ssh_config" do
  source "ssh_config.erb"
  mode 0644
  owner "root"
  group "root"
end

template "/etc/ssh/sshd_config" do
  source "sshd_config.erb"
  mode 0644
  owner "root"
  group "root"
  notifies :restart, resources(:service => "ssh")
end


service "ssh" do
  action :start
end