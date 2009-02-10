bash "Set domain name" do
  code "echo #{node[:assigned_domain]} /etc/domainname"
end

bash "Set hostname" do
  code "echo #{node[:assigned_hostname]}.#{node[:assigned_domain]} > /etc/hostname"
end

bash "Set mailname for postfix" do
  code "echo #{node[:assigned_hostname]}.#{node[:assigned_domain]} > /etc/mailname"
end

service "hostname.sh" do
 supports :restart => true
 action :start
end