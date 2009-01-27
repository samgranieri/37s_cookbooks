template "/etc/sudoers" do
  owner "root"
  group "root"
  source "sudoers.erb"
  mode 0440
end
