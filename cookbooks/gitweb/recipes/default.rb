require_recipe "git::server"

package "gitweb"

template "/etc/gitweb-vhost.conf" do
  source "apache-vhost.conf.erb"
end

apache_site "gitweb" do
  config_path "/etc/gitweb-vhost.conf"
end