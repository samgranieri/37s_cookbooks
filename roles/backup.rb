name "backup"
description "Backup Server"
recipes "backup::server", "rsnapshot::server", "nfs::server", "java", "gnupg", "cron", "aws::tools", "cloudfiles"

default_attributes :active_groups => {:storage => {:enabled => true}},
                   :rsnapshot =>  {
                     :backups => {
                       "storage@git:/u/git/" => {:target => "git"},
                       "storage@qb-01:/u/apps/queenbee/shared/log/" => {:target => "qb-01"},
                       "storage@qb-02:/u/apps/queenbee/shared/log/" => {:target => "qb-02"}
                     }
                   },
                   :cron => {
                     :jobs => {
                       :cloudfiles_upload => {
                         :command => '/root/cloudput.sh',
                         :minute => '0',
                         :hour => '11',
                         :user => 'root'
                       },
                       :cloudfiles_cleanup => {
                         :command => '/root/cloudsweep.sh',
                         :minute => '0',
                         :hour => '10',
                         :user => 'root'
                       },
                       :rsnapshot_hourly => {
                         :command => '/usr/bin/rsnapshot hourly',
                         :minute => '0',
                         :hour => '*/4',
                         :user => 'root'
                       },
                       :rsnapshot_daily => {
                         :command => '/usr/bin/rsnapshot daily',
                         :minute => '30',
                         :hour => '23',
                         :user => 'root'
                       },
                       :rotate_db_backups => {
                         :command => '/usr/local/bin/rotate-db-backups',
                         :minute => '0',
                         :hour => '15',
                         :user => 'root'
                       }
                     }
                   }
