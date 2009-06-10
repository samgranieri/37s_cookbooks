package "sudo" do
  action :upgrade
end

template "/etc/sudoers" do
  source "sudoers.erb"
  mode 0440
  owner "root"
  group "root"
  variables(:sudoers_groups => node[:roles][node[:role]][:sudo_groups])
end