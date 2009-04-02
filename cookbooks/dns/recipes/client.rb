template "/etc/resolv.conf" do
  source "resolv.conf.erb"
  variables ({:domain => node[:domain], :nameservers => node[:nameservers], :search => node[:domain]})
end