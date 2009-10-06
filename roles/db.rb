name "db"
description "Basic Database Server"
recipes "mysql::server", "nfs::client"

default_attributes :active_groups => {:app => {:enabled => true}},
                   :active_sudo_groups => {:app => {:enabled => true}}
