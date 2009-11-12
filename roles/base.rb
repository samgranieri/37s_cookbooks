name "base"
description "Base role that applies to all servers"
recipes "ruby-shadow", "hosts", "timezone", "sysctl", "git", "postfix", "ssh::server", "users", "sudo", "sysadmin", "mysql::client", "ruby::gc_wrapper"

default_attributes  :active_groups => {:admin => {:enabled => true}},
                    :active_sudo_groups => {:admin => {:enabled => true}},
                    :default_domain => "37signals.com"