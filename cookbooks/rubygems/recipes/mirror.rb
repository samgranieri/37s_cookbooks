directory node[:rubygems][:mirror][:base_path] do
  action :create
  owner "root"
  group "root"
  mode 0755
end

directory "/etc/rubygems" do
  mode 0755
end

template "/etc/rubygems/mirror.conf" do
  source "gemmirrorrc.erb"
  mode 0644
end

cron "gem mirror nightly update" do
  command "rsync -av rsync://master.mirror.rubyforge.org/gems #{node[:rubygems][:mirror][:base_path]} 2>&1 && gem generate_index -d /u/mirrors/gems"
  hour "5"
  only_if File.exist?(node[:rubygems][:mirror][:base_path])
end


template "/etc/apache2/sites-available/apt-mirror" do
  source 'mirror-vhost.conf.erb'
  action :create
  owner "root"
  group "www-data"
  mode 0640
end