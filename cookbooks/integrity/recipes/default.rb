
gem_package "integrity"
gem_package "do_sqlite3"
gem_package "defunkt-integrity-campfire" do
  source "http://gems.github.com"
end

directory "/u/apps/integrity" do
  owner "app"
  group "app"
  mode 0755
end

execute "setup_integrity" do
  command "integrity install #{node[:integrity][:path]} --passenger"
  user "app"
  group "app"
  not_if "test -e /u/apps/integrity"
end
