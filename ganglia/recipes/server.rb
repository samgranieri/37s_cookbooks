
include_recipe "apache2"

package "ganglia-webfrontend"
package "gmetad"

template "/etc/ganglia/vhost.conf" do
  source "ganglia-vhost.conf.erb"
  backup false
  owner "root"
  group "www-data"
  mode 0640
end

apache_site "ganglia" do
  config_path "/etc/ganglia/vhost.conf"
end

service "gmetad" do
  enabled true
end

cluster_nodes = {}
search(:node, '*', %w(fqdn ganglia_cluster_name)) do |node|
  next unless node['ganglia_cluster_name']
  cluster_nodes[node['ganglia_cluster_name']] ||= []
  cluster_nodes[node['ganglia_cluster_name']] << node['fqdn'].split('.').first
end

template "/etc/ganglia/gmetad.conf" do
  source "gmetad.conf.erb"
  backup false
  owner "ganglia"
  group "ganglia"
  mode 0644
  variables(:cluster_nodes => cluster_nodes)
  notifies :restart, resources(:service => "gmetad")
end
