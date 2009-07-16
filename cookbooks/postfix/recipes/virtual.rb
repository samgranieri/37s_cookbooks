require_recipe "postfix"

execute "update-postfix-virtual-domains" do
  command "/usr/sbin/postmap virtual"
  action :nothing
end

if node[:postfix][:enable_virtual_domains]
  template "/etc/postfix/virtual" do
    source "virtual.erb"
    notifies :run, resources("execute[update-postfix-virtual-domains]")
    notifies :reload, resources(:service => "postfix")
  end
end
