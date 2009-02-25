package "ejabberd"

template "/etc/ejabberd/ejabberd.cfg" do
  source "ejabberd.cfg.erb"
  variables(:jabber_domain => node[:base][:jabber_domain])
end

execute "add ejabberd admin user" do
  command "ejabberdctl register admin #{node[:jabber_domain]} #{node[:base][:jabber_admin_password]}"
end
