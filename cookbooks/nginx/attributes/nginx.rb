default.nginx[:version] = "nginx_0.7.62-0~ppa1"
default.nginx[:architecture] = "amd64"

default.nginx[:dir]     = "/etc/nginx"
default.nginx[:log_dir] = "/var/log/nginx"
default.nginx[:user]    = "www-data"
default.nginx[:group]   = "www-data"
default.nginx[:binary]  = "/usr/sbin/nginx"

default.nginx[:gzip] = "on"               unless attribute?("nginx_gzip")
default.nginx[:gzip_http_version] = "1.0" unless attribute?("nginx_gzip_http_version")
default.nginx[:gzip_comp_level] = "2"     unless attribute?("nginx_gzip_comp_level")
default.nginx[:gzip_proxied] = "any"      unless attribute?("nginx_gzip_proxied")
default.nginx[:gzip_types] = [ "text/plain", "text/html", "text/css", "application/javascript", "application/x-javascript", "text/xml", "application/xml", "application/xml+rss", "text/javascript" ] unless attribute?("nginx_gzip_types")

default.nginx[:keepalive] = "off"       unless attribute?("nginx_keepalive")
default.nginx[:keepalive_timeout] = 65 unless attribute?("nginx_keepalive_timeout")

default.nginx[:worker_processes] = 1               unless attribute?("nginx_worker_processes")
default.nginx[:worker_connections] = 1024          unless attribute?("nginx_worker_connections")
default.nginx[:server_names_hash_bucket_size] = 64 unless attribute?("nginx_server_names_hash_bucket_size")

default.nginx[:expires] = Mash.new
default.nginx[:expires][:enabled] = true
default.nginx[:expires][:regex] = '\.(ico|css|js|gif|jp?g|png)(\?[0-9]+)?'
default.nginx[:expires][:time] = "max"

default.nginx[:extras] = ['headers']
default.nginx[:helpers] = ['expires', 'lb_filter']
