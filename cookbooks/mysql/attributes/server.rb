mysql Mash.new unless attribute?(:mysql)
default[:mysql][:root] = "/u/mysql"
default[:mysql][:uid]  = 5000
default[:mysql][:gid]  = 5000
default[:mysql][:perform_backups] = false
default[:mysql][:backup_hour] = "06"
