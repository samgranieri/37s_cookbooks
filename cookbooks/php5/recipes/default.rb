unless node[:platform] == "ubuntu"
  Chef::Log.warn("This recipe is only available for Ubuntu systems.")
  return
end

package "apache2-mpm-worker"
package "libapache2-mod-fcgid"
apache_module "fcgid"

bash "install_php" do
  code <<-EOC
wget #{node[:php5][:dist_url]}
tar -C /#{node[:php5][:path].split("/")[1..-2].join("/")} -xpf #{node[:php5][:tar_pkg]}
EOC
  user "root"
  cwd "/tmp"
  not_if { File.directory?(node[:php5][:path]) }
end

link "/usr/local/php/bin/php-cgi" do
  to "/usr/bin/php-cgi"
end
