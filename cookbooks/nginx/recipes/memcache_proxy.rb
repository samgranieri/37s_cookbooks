require_recipe "nginx"

template "/etc/nginx/sites-available/memcache_proxy" do
  source "memcache_proxy.conf.erb"
end