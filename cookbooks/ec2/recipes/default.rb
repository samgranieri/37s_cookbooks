bootstrap_fqdn = "#{node[:assigned_hostname]}.#{node[:assigned_domain]}"

bash "Add temporary hosts entry for current node" do
  code "echo '#{node[:ipaddress]} #{bootstrap_fqdn}' >> /etc/hosts"
end

bash "Set domain name" do
  code "echo #{node[:assigned_domain]} /etc/domainname"
end

bash "Set hostname" do
  code "echo #{bootstrap_fqdn} > /etc/hostname"
  not_if "grep #{bootstrap_fqdn} /etc/mailname"
end

bash "Set mailname for postfix" do
  code "echo #{bootstrap_fqdn} > /etc/mailname"
  notifies :restart, resources(:service => "postfix")
  not_if "grep #{node[:assigned_hostname]} /etc/mailname"
end

service "hostname.sh" do
 supports :restart => true
 action :start
end