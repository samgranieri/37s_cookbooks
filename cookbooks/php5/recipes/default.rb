unless node[:platform] == "ubuntu"
  Chef::Log.warn("This recipe is only available for Ubuntu systems.")
  return
end

package "apache2-mpm-worker"
package "php5-cli"
package "libapache2-mod-fcgid"
apache_module "fcgid"
