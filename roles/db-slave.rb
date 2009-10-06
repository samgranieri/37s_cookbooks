name 'db-slave'
description 'Slave Database Server'
recipes 'cron', 'mysql::server', 'syslog::client', 'nfs::client'

override_attributes :active_groups => {:app => {:enabled => true}},
                    :active_sudo_groups => {:app => {:enabled => true}},
  :nfs_mounts => {
    "/u/backup/mysql" => { "device" => "172.28.10.188:/u/backup/db", "owner" => "root" }
  },
  :cron => { :jobs => {} },
  :mysql => { 
    :instances => [
      { 
        :name => "backpack",
        :version => "4.1.22",
        :backup_location => "/u/backup/mysql/backpack/current",
        :config => { 
          :port => "3307",
 	  :server_id => "1623307",
          :innodb_buffer_pool_size => "3G",
          :innodb_file_per_table => false
        }
      },
      { 
        :name => "campfire",
        :version => "4.1.22",
	:backup_location => "/u/backup/mysql/campfire/current",
        :config => { 
          :port => "3312",
	  :server_id => "1623312",
          :innodb_buffer_pool_size => "16G",
          :innodb_file_per_table => false
        }
      },
      { 
        :name => "champagne",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/champagne/current",
        :config => { 
          :port => "3316",
	  :server_id => "1623316",
          :innodb_buffer_pool_size => "250M"
        }
      },
      { 
        :name => "extra_extra",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/extra_extra/current",
        :config => { 
          :port => "3309",
	  :server_id => "1623309",
          :innodb_buffer_pool_size => "250M"
        }
      },
      { 
        :name => "haystack",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/haystack/current",
        :config => { 
          :port => "3317",
	  :server_id => "1623317",
          :innodb_buffer_pool_size => "2G"
        }
      },                   
      { 
        :name => "highrise",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/highrise/current",
        :config => { 
          :port => "3306",
	  :server_id => "1623306",
          :innodb_buffer_pool_size => "20G"
        }
      },
      { 
        :name => "jobs",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/jobs/current",
        :config => { 
          :port => "3308",
	  :server_id => "1623308",
          :innodb_buffer_pool_size => "250M"
        }
      },
      { 
        :name => "junta",
        :version => "4.1.22",
	:backup_location => "/u/backup/mysql/junta/current",
        :config => { 
          :port => "3311",
	  :server_id => "1623311",
          :innodb_buffer_pool_size => "100M",
          :innodb_file_per_table => false
        }
      },
      { 
        :name => "mogile",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/mogile/current",
        :config => { 
          :port => "3314",
	  :server_id => "1623314",
          :innodb_log_file_size => "50M",
          :innodb_buffer_pool_size => "512M"
        }
      },
      { 
        :name => "openbar",
        :version => "4.1.22",
	:backup_location => "/u/backup/mysql/openbar/current",
        :config => { 
          :port => "3313",
	  :server_id => "1623313",
          :innodb_buffer_pool_size => "100M",
          :innodb_file_per_table => false
        }
      },

      { 
        :name => "queenbee",
        :version => "5.0.84-percona",
	:backup_location => "/u/backup/mysql/queenbee/current",
        :config => { 
          :port => "3315",
	  :server_id => "1623315",
          :innodb_log_file_size => "100M",
          :innodb_buffer_pool_size => "4G"
        }
      },
      { 
        :name => "writeboard",
        :version => "4.1.22",
	:backup_location => "/u/backup/mysql/writeboard/current",
        :config => { 
          :port => "3310",
	  :server_id => "1623310",
          :innodb_buffer_pool_size => "2G",
          :innodb_file_per_table => false
        }
      }
    ]
  }
