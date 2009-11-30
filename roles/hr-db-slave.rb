name 'hr-db'
description 'Highrise Database Server'
recipes 'cron', 'mysql::server', 'syslog::client', 'nfs::client'

override_attributes :active_groups => {:app => {:enabled => true}},
                    :active_sudo_groups => {:app => {:enabled => true}},
  :nfs_mounts => {
    "/u/backup/mysql" => { "device" => "172.28.10.188:/u/backup/db", "owner" => "root" }
  },
  :cron => { :jobs => {} },
  :mysql => {
    :perform_backups => true,
    :instances => [
      { 
        :name => "highrise",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/highrise/current",
        :config => { 
          :port => "3306",
	  :server_id => "2183306",
          :innodb_buffer_pool_size => "115G",
          :innodb_thread_concurrency => "6"
        }
      }
    ]
  }
