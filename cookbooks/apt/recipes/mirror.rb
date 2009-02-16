require_recipe "apt"

directory node[:apt][:base_path] do
  action :create
  owner "root"
  group "root"
  mode 0755
end