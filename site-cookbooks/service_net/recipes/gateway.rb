
require_recipe "iptables"

iptables_rule "service_net" do
  service_interface node[:service_net][:service_interface]
  local_interface node[:service_net][:local_interface]
end
