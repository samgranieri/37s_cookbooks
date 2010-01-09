require_recipe "git::server"

package "gitweb"

directory node[:gitweb][:config_path] do
  mode 0755
  recursive true
end

template "/etc/gitweb/apache.conf"

template "/etc/gitweb/projects.conf" do
  variables :projects => node[:git][:repos]
end

apache_site "gitweb" do
  config_path "/etc/gitweb/apache.conf"
end