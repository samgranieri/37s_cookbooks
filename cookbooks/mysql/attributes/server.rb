mysql Mash.new unless attribute?(:mysql)

mysql[:server][:root] = "/u/mysql"
mysql[:server][:log_root] = "#{mysql[:server][:root]}/logs"
mysql[:server][:mysqld_error_log] = "#{mysql[:server][:root]}/logs/mysql.err"
mysql[:server][:socket_path] = "/tmp/mysql.sock"
mysql[:server][:slow_query_log] = "#{mysql[:server][:root]}/logs/mysql_slow_queries.log"
mysql[:server][:error_log] = "#{mysql[:server][:root]}/logs/mysql.log.err"
mysql[:server][:binlog_dir] = "#{mysql[:server][:root]}/binlogs"
mysql[:server][:pidfile] = "/var/run/mysqld/mysqld.pid"
mysql[:server][:server_id] = "1"
mysql[:server][:binlogs_enabled] = false
mysql[:server][:port] = "3306"
mysql[:server][:innodb_file_per_table] = true
mysql[:server][:innodb_buffer_pool_size] = "2G"
