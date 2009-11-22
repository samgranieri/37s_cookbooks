gem_package "bluepill" do
  version node[:bluepill][:version]
end

directory "/etc/bluepill" do
  owner "root"
  group "root"
  mode 0755
end

directory "/var/log/bluepill" do
  owner "root"
  group "root"
  mode 0755
end

directory "/var/run/bluepill" do
  owner "root"
  group "root"
  mode 0755
end
