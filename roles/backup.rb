name "backup"
description "Backup Server"
recipes "backup::server", "rsnapshot::server", "nfs::server", "java", "gnupg"

default_attributes :active_groups => {:storage => {:enabled => true}},
                   :rsnapshot =>  {
                     :backups => {
                       "storage@git:/u/git" => "git"
                     }
                   }
