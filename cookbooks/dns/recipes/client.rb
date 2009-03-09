template "/etc/resolv.conf" do
  source "resolv.conf.erb"
  variables ({:domain => node[:domain], :nameservers => []})
end