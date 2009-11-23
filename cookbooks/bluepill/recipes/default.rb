gem_package "bluepill" do
  version node[:bluepill][:version]
end

directory node[:bluepill][:config_dir]
directory node[:bluepill][:log_dir]
directory node[:bluepill][:pid_dir]

template "/etc/init.d/bluepill" do
  source "init.sh.erb"
  mode 0755
end

service "bluepill"
