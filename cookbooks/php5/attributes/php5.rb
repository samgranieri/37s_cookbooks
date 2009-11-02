php5 Mash.new unless attribute?("php5")
default[:php5][:version] = "5.3.0"
default[:php5][:path] = "/usr/local/php"
default[:php5][:tar_pkg] = "php-#{php5[:version]}-#{platform}-#{platform_version}-#{kernel[:machine]}.tar.bz2"
default[:php5][:dist_url] = "http://dist/packages/#{php5[:tar_pkg]}"
