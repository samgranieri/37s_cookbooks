pkg = "redis-server_#{node[:redis][:version]}_amd64.deb"

remote_file "/tmp/#{pkg}" do
  source "http://dist/debs/intrepid/redis/#{pkg}"
end

package pkg do
  provider Chef::Provider::Package::Dpkg
  source "/tmp/#{pkg}"
  only_if "test -e /tmp/#{pkg}"
end