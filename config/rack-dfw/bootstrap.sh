#!/bin/sh
#
# EC2 bootstrap
#
export PATH=$PATH:/usr/local/bin

mkdir /etc/chef
mkdir /var/chef

cat > /etc/chef/solo.rb <<SOLO
cookbook_path     "/var/chef/cookbooks"
node_path         "/var/chef/nodes"
log_level         :info
file_store_path  "/var/chef"
file_cache_path  "/var/chef"
SOLO

cat > /etc/chef/bootstrap.json <<BOOTSTRAP
{
 "role": "$1",
 "recipes": ["base", "chef::client"]
}
BOOTSTRAP

echo 372fa8ac3d0f87395f986314897b835a > /etc/chef/validation_token

wget -P /tmp http://dist/debs/intrepid/ruby/ruby-enterprise_1.8.6-20090201_amd64.deb
dpkg -i /tmp/ruby-enterprise_1.8.6-20090201_amd64.deb
gem sources -a http://gems
gem install chef --no-rdoc --no-ri

apt-get update

chef-solo -j /etc/chef/bootstrap.json -r http://dist/cookbooks.tgz
