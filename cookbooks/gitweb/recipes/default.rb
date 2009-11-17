require_recipe "git::server"

package "gitweb"

directory node[:gitweb][:config_path] do
  mode 0755
  recursive true
end

template "/etc/gitweb/apache.conf"

template "/etc/gitweb/projects.conf" do
  projects = node[:git][:repos].delete_if { |name, conf| conf[:visible] == false }.keys
  variables :projects => projects
end

apache_site "gitweb" do
  config_path "/etc/gitweb/apache.conf"
end

if node[:git][:repos]
  node[:git][:repos].each do |name, config|
    link "#{node[:gitweb][:repo_root]}/#{name}" do
      to "#{node[:git][:repo_root]}/#{name}"
      not_if { config[:gitweb] == false }
    end
  end
end