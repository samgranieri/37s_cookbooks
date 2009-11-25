
route "10.191.192.0" do
  route_type :net
  netmask "255.255.192.0"
  gateway node[:service_net][:gateway_ip]
  metric 1
end
