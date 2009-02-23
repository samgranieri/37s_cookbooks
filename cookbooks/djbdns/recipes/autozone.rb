# This recipe will generate a zone file from the chef server's node list. Requires chef-client
# It also automatically generates an authoritative zone record for the current domain and an A record for 'chef' pointing to the current server

include_recipe "djbdns::internal_server"

hosts = []
search(:node, "*") {|n| hosts << n }

template "/etc/tinydns-internal/root/zones/chef-server.zone" do
  source "tinydns-internal-data.erb"
  mode 644
  variables(:hosts => hosts)
  notifies :run, resources("execute[build-tinydns-internal-data]")
end