mysql ||= Mash.new
default[:mysql][:root] = "/u/mysql"
default[:mysql][:uid]  = 5000
default[:mysql][:gid]  = 5000
