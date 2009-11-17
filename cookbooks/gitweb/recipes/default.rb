require_recipe "git::server"

package "gitweb"

directory node[:gitweb][:active_repos] do
  mode 0755
end

template "/etc/gitweb-vhost.conf" do
  source "apache-vhost.conf.erb"
end

apache_site "gitweb" do
  config_path "/etc/gitweb-vhost.conf"
end

if node[:git][:repos]
  node[:git][:repos].each do |name, config|
    link "#{node[:gitweb][:repo_root]}/#{name}" do
      to "#{node[:git][:repo_root]}/#{name}"
      not_if { config[:gitweb] == false }
    end
  end
end