apt-get -y install emacs22-nox vim git-core mysql-client libmysqlclient15-dev build-essential syslog-ng ntp ruby ruby1.8-dev rubygems libopenssl-ruby1.8 irb rdoc ri
cd /tmp
wget http://rubyforge.org/frs/download.php/45904/rubygems-update-1.3.1.gem
sudo gem install rubygems-update-1.3.1.gem
sudo /var/lib/gems/1.8/bin/update_rubygems
sudo cp /usr/bin/gem1.8 /usr/bin/gem
sudo gem sources -a http://gems.opscode.com
sudo gem install chef ohai # install chef-server on noc
mkdir -p /etc/chef

echo '
#
# Chef Solo Config File
#
log_level          :info
log_location       STDOUT
file_cache_path    "/tmp/chef-solo"
cookbook_path      "/tmp/chef-solo/cookbooks"
Chef::Log::Formatter.show_time = false
' > /etc/chef/solo.rb
chef-solo -r http://wiki.opscode.com/download/attachments/1179839/chef-server-install-solo.tar.gz
