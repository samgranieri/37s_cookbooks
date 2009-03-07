gem_package "builder"

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
  # the following delete command ensures generate_index won't fail on broken win32 gems (sorry, windows people)
  command "rsync -av rsync://master.mirror.rubyforge.org/gems #{node[:rubygems][:mirror][:base_path]}/gems && find #{node[:rubygems][:mirror][:base_path]}/gems -name \"*win32*\" -delete && gem generate_index -d /u/mirrors/gems > /var/log/gem-mirror.log 2>&1"
  hour "5"
end

template "/etc/apache2/sites-available/gem-mirror" do
  source 'mirror-vhost.conf.erb'
  action :create
  owner "root"
  group "www-data"
  mode 0640
end

apache_site "gem-mirror"
