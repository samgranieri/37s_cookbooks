name "backup"
description "Backup Server"
recipes "backup::server", "rsnapshot::server", "nfs::server", "java", "gnupg"

default_attributes :active_groups => {:storage => {:enabled => true}},
                   :rsnapshot =>  {
                     :backups => {
                       "storage@git:/u/git/" => {:target => "git"},
                       "storage@qb-01:/u/apps/queenbee/shared/log/" => {:target => "qb-01"},
                       "storage@qb-02:/u/apps/queenbee/shared/log/" => {:target => "qb-02"}
                     }
                   }
