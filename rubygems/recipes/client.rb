template "/etc/gemrc" do
  source "gemrc.erb"
  mode 0644
end

execute "update rubygems" do
  command "gem update --system"
  not_if { `gem -v`.chomp == node[:rubygems][:version] }
end