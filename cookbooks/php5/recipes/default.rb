unless node[:platform] == "ubuntu"
  Chef::Log.warn("This recipe is only available for Ubuntu systems.")
  return
end

template "php5.load" do
  path "/etc/apache2/mods-available/php5.load"
  source "php5.load.erb"
  owner "root"
  mode 0644
end

template "php5.conf" do
  path "/etc/apache2/mods-available/php5.conf"
  source "php5.conf.erb"
  owner "root"
  mode 0644
end

bash "install_php" do
  code <<-EOC
wget #{node[:php5][:dist_url]}
tar -C /#{node[:php5][:path].split("/")[1..-2].join("/")} -xpf #{node[:php5][:tar_pkg]}
EOC
  user "root"
  cwd "/tmp"
  not_if { File.directory?(node[:php5][:path]) }
end
