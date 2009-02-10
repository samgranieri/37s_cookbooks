#!/bin/sh

apt-get update
DEBCONF_TERSE='yes' DEBIAN_PRIORITY='critical' DEBIAN_FRONTEND=noninteractive apt-get -qyu install emacs22-nox vim git-core mysql-client libshadow-ruby1.8 libmysqlclient15-dev build-essential syslog-ng ntp ruby ruby1.8-dev rubygems libopenssl-ruby1.8 irb rdoc ri rubygems man rake
cd /tmp && wget http://rubyforge.org/frs/download.php/45904/rubygems-update-1.3.1.gem && sudo gem install rubygems-update-1.3.1.gem && sudo /var/lib/gems/1.8/bin/update_rubygems
mkdir -p /etc/chef /var/chef /var/chef/merb/log /var/chef/openid/cstore && chown -R www-data /var/chef/openid /var/chef/merb
sudo gem sources -a http://gems.opscode.com && gem sources -a http://gems.github.com
gem install rspec json --no-rdoc --no-ri
git clone git://github.com/opscode/ohai.git
cd ohai && rake install
git clone git://github.com/opscode/chef.git
cd chef && rake install
