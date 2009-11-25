
require_recipe "iptables"

iptables_rule "service_net" do
  service_interface service_net[:service_interface]
  local_interface service_net[:local_interface]
end
