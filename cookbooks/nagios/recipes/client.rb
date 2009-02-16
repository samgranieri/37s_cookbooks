require_recipe 'nagios'

remote_directory "/var/lib/nagios/custom-plugins" do
  source "plugins"
  files_backup 5
  files_owner "nagios"
  files_group "nagios"
  files_mode 0644
  owner "nagios"
  group "nagios"
  mode "0755"
end