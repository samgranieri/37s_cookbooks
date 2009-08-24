name "backup"
description "Backup Server"
recipes "backup::server", "nfs::server", "jruby"

default_attributes :active_groups => {:storage => {:enabled => true}}
